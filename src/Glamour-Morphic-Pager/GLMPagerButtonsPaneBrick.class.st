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
	
	aBrick enable.
	aBrick index: self buttons size.
	aBrick announcer weak subscribe: GLMPagerButtonClicked send: #scrollButtonClicked: to: self.
	aBrick announcer weak subscribe: GLMPagerButtonSelected send: #scrollButtonSelected: to: self.
	aBrick announcer weak subscribe: GLMPagerButtonDeselected send: #scrollButtonDeselected to: self.
	
	GLMPagerWidgetThemer new defaultScrollButtonStyleFor: aBrick.
	
	aBrick height: self pagerModel circleButtonSize.
	aBrick width: self pagerModel circleButtonSize.
	
	self addBrickBack: aBrick.
	self doLayoutForce.
	self changed.
	
	(self buttons size = 1) ifTrue: [ self updateButtonsFocus ].
		
	self updateButtons.
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
	
	self buttons do: [ :indicator |
		index := index + 1.
		(self isScrollMustBeChecked: index withLeft: boundsLeft andRight: boundsRight)
			ifTrue: [
				indicator check.
				firstFound ifFalse: [
					pagerModel virtualFirstVisiblePageIndex: index.
					firstFound := true.
				]
			]
			ifFalse: [
				"uncheck only if not focused"
				indicator isFocused ifFalse: [ indicator uncheck ].
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

	^ GLMPagerScrollButtonBrick new
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onFocusedPageChanged [

	self updateButtonsFocus.
	self updateButtons.

]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPagePoped [
	|button|
	
	button := self buttons removeLast.
	button announcer unsubscribe: self.
	
	self removeBrick: button.
	self updateButtons.
	
	self doLayoutForce.
	self changed
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPagePushed: addedAnnouncement [
	
	self addButton: self newButton
]

{ #category : #'buttons-event-handling' }
GLMPagerButtonsPaneBrick >> onPageSwitched [

	self updateButtons
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
		
	self updateButtons
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> scrollButtonClicked: clickedAnnouncement [

	"notify adapter that we need to switch page"
	pagerModel switchPaneTo: clickedAnnouncement buttonModel index
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> scrollButtonDeselected [

	GLMPagerPanePreviewMorph uniqueInstance hideFromWorld.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> scrollButtonSelected: selectedAnnouncement [

	"notify adapter that we need to update pane preview"
	
	GLMPagerPanePreviewMorph uniqueInstance showAt: (self buttons at: selectedAnnouncement buttonModel index) bounds topCenter.
	pagerModel updatePreview: selectedAnnouncement buttonModel index.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> updateButtons [
	"first we uncheck all buttons"
	self buttons do: [ :each |
		"uncheck only if not focused"
		each isFocused ifFalse: [ each uncheck ] ].
	
	"then check only necessary"
	self pagerModel size > 0 ifTrue: [
		self buttons from: self pagerModel firstVisiblePageIndex to: self pagerModel lastVisiblePageIndex do: #check ]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonsPaneBrick >> updateButtonsFocus [

	"unfocus all"
	self buttons do: #setNotFocused.
	
	"because it's possible when nothing has focus"
	self pagerModel focusedPageIndex ifNotNil: [ (self buttons at: self pagerModel focusedPageIndex) setFocused ].
	
]
