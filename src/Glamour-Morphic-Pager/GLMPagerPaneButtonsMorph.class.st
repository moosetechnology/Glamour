Class {
	#name : #GLMPagerPaneButtonsMorph,
	#superclass : #Morph,
	#instVars : [
		'adapter',
		'indicatorButtons'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> addCircleButton: aMorph [
	self addMorphBack: aMorph.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> buttonCenterByIndex: aNumber [
	|left width|
	width := adapter circleButtonSize.
	left := self bounds left.
	^ left + ( ( aNumber - 1 ) * ( width ) ) + ( width / 2 ).
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> circleButtonClicked: clickedAnnouncement [

	"notify adapter that we need to switch page"
	adapter switchPaneTo: clickedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> circleButtonDeselected [

	GLMPagerPanePreviewMorph uniqueInstance hideFromWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> circleButtonSelected: selectedAnnouncement [

	"notify adapter that we need to update pane preview"
	
	GLMPagerPanePreviewMorph uniqueInstance showAt: (indicatorButtons at: selectedAnnouncement buttonModel pageIndex) bounds topCenter.
	adapter updatePreview: selectedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> isCircleMustBeChecked: anIndex withLeft: leftBound andRight: rightBound [
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
		(self isCircleMustBeChecked: index withLeft: boundsLeft andRight: boundsRight)
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
	
	self removeCircleButton: button.
	self updateIndicatorButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> onPagePushed: addedAnnouncement [
	|button|
	
	button := GLMPagerCircleButtonMorph new.
	indicatorButtons addLast: button.
	
	button buttonModel: (GLMPagerCircleButtonModel new pageIndex: indicatorButtons size).
	button buttonModel on: GLMPagerButtonClicked send: #circleButtonClicked: to: self.
	button buttonModel on: GLMPagerButtonSelected send: #circleButtonSelected: to: self.
	button buttonModel on: GLMPagerButtonDeselected send: #circleButtonDeselected to: self.
	adapter circleButtonIconRenderBlock ifNotNil: [ 
		button image state normal: (adapter circleButtonIconRenderBlock value: indicatorButtons size).
		button image state selected: (adapter circleButtonIconRenderBlock value: indicatorButtons size).
		button image state checked: (adapter circleButtonIconRenderBlock value: indicatorButtons size).
		button checkedIcon: (adapter circleButtonIconRenderBlock value: indicatorButtons size).
		button checkedFocusedIcon: (adapter circleButtonIconRenderBlock value: indicatorButtons size).
	].
	
	button height: adapter circleButtonSize.
	button width: adapter circleButtonSize.
	
	self addCircleButton: button.
	
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
GLMPagerPaneButtonsMorph >> removeCircleButton: aButton [

	self removeMorph: aButton.
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

{ #category : #'as yet unclassified' }
GLMPagerPaneButtonsMorph >> width [
	|width|
	width := adapter isNotNil
		ifTrue: [ ( indicatorButtons size * ( adapter circleButtonSize ) ) ]
		ifFalse: [ 0 ].
	^ width
]
