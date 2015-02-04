Class {
	#name : #GLMPagerButtonsPaneBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'pagerModel',
		'buttons'
	],
	#category : #'Glamour-Morphic-Pager-Brick'
}

{ #category : #'buttons-adding' }
GLMPagerButtonsPaneBrick >> addButton: aBrick [

	self buttons add: aBrick.
	"aBrick buttonModel: (GLMPagerScrollButtonModel new pageIndex: self buttons size).
	aBrick buttonModel on: GLMPagerButtonClicked send: #scrollButtonClicked: to: self.
	aBrick buttonModel on: GLMPagerButtonSelected send: #scrollButtonSelected: to: self.
	aBrick buttonModel on: GLMPagerButtonDeselected send: #scrollButtonDeselected to: self."
	
	"GLMPagerWidgetThemer new defaultScrollButtonStyleFor: aBrick."
	
	aBrick height: self pagerModel circleButtonSize.
	aBrick width: self pagerModel circleButtonSize.
	
	self addBrickBack: aBrick.
	
	(self buttons size = 1) ifTrue: [ self updateIndicatorButtonsFocus ].
		
	self updateIndicatorButtons.
]

{ #category : #'buttons-calculations' }
GLMPagerButtonsPaneBrick >> buttonCenterByIndex: aNumber [
	|left width|
	width := self pagerModel circleButtonSize.
	left := self bounds left.
	^ left + ( ( aNumber - 1 ) * ( width ) ) + ( width / 2 ).
]

{ #category : #'buttons-accessing' }
GLMPagerButtonsPaneBrick >> buttons [

	^ buttons ifNil: [ buttons := OrderedCollection new ]
]

{ #category : #'buttons-accessing' }
GLMPagerButtonsPaneBrick >> buttons: anObject [

	buttons := anObject
]

{ #category : #initialization }
GLMPagerButtonsPaneBrick >> initialize [
	super initialize.
		
	self hShrinkWrap.
	
	buttons := OrderedCollection new
]

{ #category : #testing }
GLMPagerButtonsPaneBrick >> isScrollMustBeChecked: anIndex withLeft: leftBound andRight: rightBound [
	| buttonCenter |
	
	buttonCenter := self buttonCenterByIndex: anIndex.
	^ (leftBound <= buttonCenter ) & (rightBound > buttonCenter)
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> markButtonsInside: aBounds [
	""
	|index boundsLeft boundsRight firstFound lastFound |	
	
	firstFound := false.
	lastFound := false.
	index := 0.
	
	(pagerModel size = 0) ifTrue: [ ^ self ].
	boundsLeft := aBounds x.
	boundsRight := aBounds y.
	
	buttons do: [ :indicator |
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

{ #category : #'buttons-instance-creation' }
GLMPagerButtonsPaneBrick >> newButton [

	^ GLMInteractableBrick new
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onFocusedPageChanged [

	self updateIndicatorButtonsFocus.
	self updateIndicatorButtons.

]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPagePoped [
	|button|
	
	button := buttons last.
	buttons removeLast.
	button announcer unsubscribe: self.
	
	self removeScrollButton: button.
	self updateIndicatorButtons.
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPagePushed: addedAnnouncement [
	
	self addButton: self newButton
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPageSwitched [

	self updateIndicatorButtons.
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onScrollBoundsChanged: boundsChangedAnnouncement [

	self markButtonsInside: boundsChangedAnnouncement bounds.
	
]

{ #category : #'buttons-accessing' }
GLMPagerButtonsPaneBrick >> pagerModel [

	^ pagerModel
]

{ #category : #'buttons-accessing' }
GLMPagerButtonsPaneBrick >> pagerModel: aModel [
	
	pagerModel := aModel.
		
	self pagerModel announcer weak subscribe: GLMPageSwitched send: #onPageSwitched to: self.
	self pagerModel announcer weak subscribe: GLMPagerBoundsChanged send: #onScrollBoundsChanged: to: self.
	self pagerModel announcer weak subscribe: GLMFocusedPageChanged send: #onFocusedPageChanged to: self.
		
	self updateIndicatorButtons
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> removeScrollButton: aButton [

	self removeMorph: aButton.
]

{ #category : #testing }
GLMPagerButtonsPaneBrick >> renderCustomScrollButtonIcons: anIcons for: aButton [
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
GLMPagerButtonsPaneBrick >> scrollButtonClicked: clickedAnnouncement [

	"notify adapter that we need to switch page"
	pagerModel switchPaneTo: clickedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> scrollButtonDeselected [

	GLMPagerPanePreviewMorph uniqueInstance hideFromWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> scrollButtonSelected: selectedAnnouncement [

	"notify adapter that we need to update pane preview"
	
	GLMPagerPanePreviewMorph uniqueInstance showAt: (buttons at: selectedAnnouncement buttonModel pageIndex) bounds topCenter.
	pagerModel updatePreview: selectedAnnouncement buttonModel pageIndex.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> updateIndicatorButtons [

	"first we uncheck all buttons"
	buttons do: [ :indicator |
		"uncheck only if not focused"
		indicator isFocused ifFalse: [ "indicator buttonModel uncheck" ].
	].

	"then check only necessary"
	pagerModel size > 0 ifTrue: [
		buttons from: pagerModel firstVisiblePageIndex to: pagerModel lastVisiblePageIndex do: [ :indicator |
			"indicator buttonModel check."
		]
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> updateIndicatorButtonsFocus [

	"unfocus all"
	buttons do: [ :each |
		 "each setNotFocused."
	].
	
	"because it's possible when nothing has focus"
	pagerModel focusedPageIndex ifNotNil: [ (buttons at: pagerModel focusedPageIndex) setFocused ].
	
]

{ #category : #geometry }
GLMPagerButtonsPaneBrick >> width [
	|width|
	width := pagerModel isNotNil
		ifTrue: [ ( buttons size * ( pagerModel circleButtonSize ) ) ]
		ifFalse: [ 0 ].
	^ width
]
