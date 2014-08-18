Class {
	#name : #GLMPagerPaneButtonsMorph,
	#superclass : #Morph,
	#instVars : [
		'indicatorButtons',
		'pagerModel'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #adding }
GLMPagerPaneButtonsMorph >> addScrollButton: aMorph [
	self addMorphBack: aMorph.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> buttonCenterByIndex: aNumber [
	|left width|
	width := pagerModel circleButtonSize.
	left := self bounds left.
	^ left + ( ( aNumber - 1 ) * ( width ) ) + ( width / 2 ).
]

{ #category : #initialization }
GLMPagerPaneButtonsMorph >> initialize [
	super initialize.
		
	self 
		beTransparent;
		changeTableLayout;
		changeListDirection: #leftToRight;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center;
		hResizing: #shrinkWrap.
	
	indicatorButtons := OrderedCollection new
]

{ #category : #testing }
GLMPagerPaneButtonsMorph >> isScrollMustBeChecked: anIndex withLeft: leftBound andRight: rightBound [
	| buttonCenter |
	
	buttonCenter := self buttonCenterByIndex: anIndex.
	^ (leftBound <= buttonCenter ) & (rightBound > buttonCenter)
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> markButtonsInside: aBounds [
	""
	|index boundsLeft boundsRight firstFound lastFound |	
	
	firstFound := false.
	lastFound := false.
	index := 0.
	
	(pagerModel size = 0) ifTrue: [ ^ self ].
	boundsLeft := aBounds x.
	boundsRight := aBounds y.
	
	indicatorButtons do: [ :indicator |
		index := index + 1.
		(self isScrollMustBeChecked: index withLeft: boundsLeft andRight: boundsRight)
			ifTrue: [
				indicator buttonModel check.
				firstFound ifFalse: [
					pagerModel virtualFirstVisiblePageIndex: index.
					firstFound := true.
				]
			]
			ifFalse: [
				"uncheck only if not focused"
				indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
				(firstFound & (lastFound = false)) ifTrue: [
					pagerModel virtualLastVisiblePageIndex: index - 1.
					lastFound := true.
				]
			].
	].
	lastFound ifFalse: [
		pagerModel virtualLastVisiblePageIndex: index.
		lastFound := true.
	]
	
		

]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onFocusedPageChanged [

	self updateIndicatorButtonsFocus.
	self updateIndicatorButtons.

]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPagePoped [
	|button|
	
	button := indicatorButtons last.
	indicatorButtons removeLast.
	button announcer unsubscribe: self.
	
	self removeScrollButton: button.
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPagePushed: addedAnnouncement [
	|button|
	
	button := GLMPagerScrollButtonMorph new.
	indicatorButtons addLast: button.
	
	button buttonModel: (GLMPagerScrollButtonModel new pageIndex: indicatorButtons size).
	button buttonModel on: GLMPagerButtonClicked send: #scrollButtonClicked: to: self.
	button buttonModel on: GLMPagerButtonSelected send: #scrollButtonSelected: to: self.
	button buttonModel on: GLMPagerButtonDeselected send: #scrollButtonDeselected to: self.
	
	pagerModel scrollButtonIconRenderBlock ifNotNil: [
		self renderCustomScrollButtonIcons: (pagerModel scrollButtonIconRenderBlock value: indicatorButtons size) for: button.
	]	ifNil: [ 
		GLMPagerWidgetThemer new defaultScrollButtonStyleFor: button.
	].
	
	
	button height: pagerModel circleButtonSize.
	button width: pagerModel circleButtonSize.
	
	self addScrollButton: button.
	
	(indicatorButtons size = 1) ifTrue: [ self updateIndicatorButtonsFocus ].
		
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPageSwitched [

	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onScrollBoundsChanged: boundsChangedAnnouncement [

	self markButtonsInside: boundsChangedAnnouncement bounds.
	
]

{ #category : #accessing }
GLMPagerPaneButtonsMorph >> pagerModel: aModel [
	
	pagerModel := aModel.
		
	pagerModel announcer weak
		on: GLMPageSwitched send: #onPageSwitched to: self.
				
	pagerModel announcer weak
		on: GLMPagerBoundsChanged send: #onScrollBoundsChanged: to: self.
		
	pagerModel announcer weak
		on: GLMFocusedPageChanged send: #onFocusedPageChanged to: self.
		
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> removeScrollButton: aButton [

	self removeMorph: aButton.
]

{ #category : #testing }
GLMPagerPaneButtonsMorph >> renderCustomScrollButtonIcons: anIcons for: aButton [
	| normalIcon focusedIcon source iconSize|
	
	anIcons isCollection ifTrue: [ 
		normalIcon := anIcons first.
		focusedIcon := anIcons second.
	]
	ifFalse: [ 
		focusedIcon := anIcons.
		normalIcon := (AlphaImageMorph new image: anIcons asGrayScaleWithAlpha; alpha: 0.6) cachedForm.
	].

	iconSize := pagerModel circleButtonSize @ pagerModel circleButtonSize.
	
	source := GLMForm scaleForm: normalIcon to: iconSize / 1.6.
	normalIcon := GLMForm increaseFormExtentCentered: source to: iconSize.
	
	source := GLMForm scaleForm: focusedIcon to: iconSize / 1.6.
	focusedIcon := GLMForm increaseFormExtentCentered: source to: iconSize.
	
	aButton checkedIcon: normalIcon.
	aButton checkedFocusedIcon: focusedIcon.
	
	aButton image state normal: normalIcon.
	aButton image state selected: focusedIcon.
	aButton image state checked: aButton checkedIcon.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> scrollButtonClicked: clickedAnnouncement [

	"notify adapter that we need to switch page"
	pagerModel switchPaneTo: clickedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> scrollButtonDeselected [

	GLMPagerPanePreviewMorph uniqueInstance hideFromWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> scrollButtonSelected: selectedAnnouncement [

	"notify adapter that we need to update pane preview"
	
	GLMPagerPanePreviewMorph uniqueInstance showAt: (indicatorButtons at: selectedAnnouncement buttonModel pageIndex) bounds topCenter.
	pagerModel updatePreview: selectedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> updateIndicatorButtons [

	"first we uncheck all buttons"
	indicatorButtons do: [ :indicator |
		"uncheck only if not focused"
		indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
	].

	"then check only necessary"
	pagerModel size > 0 ifTrue: [
		indicatorButtons from: pagerModel firstVisiblePageIndex to: pagerModel lastVisiblePageIndex do: [ :indicator |
			indicator buttonModel check.
		]
	]
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> updateIndicatorButtonsFocus [

	"unfocus all"
	indicatorButtons do: [ :each |
		 each setNotFocused.
	].
	
	"because it's possible when nothing has focus"
	pagerModel focusedPageIndex ifNotNil: [ (indicatorButtons at: pagerModel focusedPageIndex) setFocused ].
	
]

{ #category : #geometry }
GLMPagerPaneButtonsMorph >> width [
	|width|
	width := pagerModel isNotNil
		ifTrue: [ ( indicatorButtons size * ( pagerModel circleButtonSize ) ) ]
		ifFalse: [ 0 ].
	^ width
]
