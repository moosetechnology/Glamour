Class {
	#name : #GLMPagerPaneButtonsMorph,
	#superclass : #Morph,
	#instVars : [
		'adapter',
		'indicatorButtons'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #accessing }
GLMPagerPaneButtonsMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
		
	adapter announcer weak
		on: GLMPageSwitched send: #onPageSwitched to: self.
				
	adapter announcer weak
		on: GLMPagerBoundsChanged send: #onScrollBoundsChanged: to: self.
		
	adapter announcer weak
		on: GLMFocusedPageChanged send: #onFocusedPageChanged to: self.
		
	self updateIndicatorButtons.
]

{ #category : #adding }
GLMPagerPaneButtonsMorph >> addScrollButton: aMorph [
	self addMorphBack: aMorph.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> buttonCenterByIndex: aNumber [
	|left width|
	width := adapter circleButtonSize.
	left := self bounds left.
	^ left + ( ( aNumber - 1 ) * ( width ) ) + ( width / 2 ).
]

{ #category : #initialization }
GLMPagerPaneButtonsMorph >> initialize [
	super initialize.
		
	self changeTableLayout;
		changeListDirection: #leftToRight;
		cellPositioning: #center;
		listCentering: #center;
		wrapCentering: #center;
		color: Color transparent.
		
	self hResizing: #shrinkWrap.
	
	
	indicatorButtons := OrderedCollection new.
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
	
	(adapter size = 0) ifTrue: [ ^ self ].
	boundsLeft := aBounds x.
	boundsRight := aBounds y.
	
	indicatorButtons do: [ :indicator |
		index := index + 1.
		(self isScrollMustBeChecked: index withLeft: boundsLeft andRight: boundsRight)
			ifTrue: [
				indicator buttonModel check.
				firstFound ifFalse: [
					adapter virtualFirstVisiblePageIndex: index.
					firstFound := true.
				]
			]
			ifFalse: [
				"uncheck only if not focused"
				indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
				(firstFound & (lastFound = false)) ifTrue: [
					adapter virtualLastVisiblePageIndex: index - 1.
					lastFound := true.
				]
			].
	].
	lastFound ifFalse: [
		adapter virtualLastVisiblePageIndex: index.
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
	
	adapter scrollButtonIconRenderBlock ifNotNil: [
		self renderCustomScrollButtonIcons: (adapter scrollButtonIconRenderBlock value: indicatorButtons size) for: button.
	]	ifNil: [ 
		GLMPagerWidgetThemer new defaultScrollButtonStyleFor: button.
	].
	
	
	button height: adapter circleButtonSize.
	button width: adapter circleButtonSize.
	
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
	] ifFalse: [
		normalIcon := anIcons.
	].

	iconSize := adapter circleButtonSize @ adapter circleButtonSize.
	
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
	adapter switchPaneTo: clickedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> scrollButtonDeselected [

	GLMPagerPanePreviewMorph uniqueInstance hideFromWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> scrollButtonSelected: selectedAnnouncement [

	"notify adapter that we need to update pane preview"
	
	GLMPagerPanePreviewMorph uniqueInstance showAt: (indicatorButtons at: selectedAnnouncement buttonModel pageIndex) bounds topCenter.
	adapter updatePreview: selectedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> updateIndicatorButtons [

	"first we uncheck all buttons"
	indicatorButtons do: [ :indicator |
		"uncheck only if not focused"
		indicator isFocused ifFalse: [ indicator buttonModel uncheck ].
	].

	"then check only necessary"
	adapter size > 0 ifTrue: [
		indicatorButtons from: adapter firstVisiblePageIndex to: adapter lastVisiblePageIndex do: [ :indicator |
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
	adapter focusedPageIndex ifNotNil: [ (indicatorButtons at: adapter focusedPageIndex) setFocused ].
	
]

{ #category : #geometry }
GLMPagerPaneButtonsMorph >> width [
	|width|
	width := adapter isNotNil
		ifTrue: [ ( indicatorButtons size * ( adapter circleButtonSize ) ) ]
		ifFalse: [ 0 ].
	^ width
]
