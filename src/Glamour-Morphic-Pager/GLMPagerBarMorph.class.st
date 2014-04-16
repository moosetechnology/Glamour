Class {
	#name : #GLMPagerBarMorph,
	#superclass : #Morph,
	#instVars : [
		'buttons',
		'scrollBar',
		'adapter'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> adapter: anAdapter [
	
	adapter := anAdapter.
	
	adapter announcer weak
		on: GLMPagePushed send: #onPagePushed: to: self.
		
	adapter announcer weak
		on: GLMPagePoped send: #onPagePoped to: self.
	
	self addButtons.
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addButtons [
	buttons ifNil: [
		buttons := GLMPagerPaneButtonsMorph new.
		buttons adapter: adapter.
		self addMorph: buttons fullFrame: (0@0 extent: 1@1).
	]
	
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addScrollBar [
	scrollBar ifNil: [
		scrollBar := GLMSlidingScrollMorph new.
		scrollBar adapter: adapter.
		"scrollBar height: self height."
		scrollBar height: adapter circleButtonSize + adapter circleButtonInset.
		
		self addMorph: scrollBar fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 0 @ 0)
					offsets: (0 @ 0 corner: (scrollBar computeWidth) @ (adapter circleButtonSize + adapter circleButtonInset)))
	]
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> bounds: newBounds [
	|rect left right   |
	
	rect := newBounds.
	
	left := rect origin.
	right := rect corner.
	
	
	adapter ifNotNil: [
		left := left  - (adapter circleButtonInset / 2 @ 0).
		right := right  + (adapter circleButtonInset / 2 @ 0).
	].
	
	rect := left corner: right.
	
	super bounds: rect
]

{ #category : #initialization }
GLMPagerBarMorph >> initialize [
	super initialize.
		
	self 
		color: Color transparent;
		changeProportionalLayout;
		borderWidth: 0.
	self
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> onPagePoped [

	buttons onPagePoped.
	scrollBar width: scrollBar computeWidth.
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> onPagePushed: addedAnnouncement [

	buttons onPagePushed: addedAnnouncement.	
	self showOrHideScrollBar.
	scrollBar width: scrollBar computeWidth.
	scrollBar setWidthAfterResizingRight.
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> removeScrollBar [
	scrollBar ifNotNil: [
		self removeMorph: scrollBar.
		scrollBar delete.
		scrollBar := nil.
	] 
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> showOrHideScrollBar [
	
	true "adapter pagesCount > adapter numberOfVisiblePages"
		ifTrue: [self addScrollBar ]
		ifFalse: [ self removeScrollBar ].
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> width [
	^ buttons width
]
