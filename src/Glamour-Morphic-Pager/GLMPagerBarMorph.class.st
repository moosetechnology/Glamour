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
	self addScrollBar.
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addButtons [
	buttons ifNil: [
		buttons := adapter isDependenciesShown ifTrue: [ GLMPagerPaneDependencyButtonsMorph new ] ifFalse: [ GLMPagerPaneButtonsMorph new ].
		buttons adapter: adapter.
		self addMorph: buttons fullFrame: (0@0 extent: 1@1).
	]
	
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addScrollBar [
	scrollBar ifNil: [
		scrollBar := GLMSlidingScrollMorph new.
		scrollBar adapter: adapter.
		scrollBar height: adapter circleButtonSize.
		
		self addMorph: scrollBar fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 0 @ 0)
					offsets: (0 @ 0 corner: (scrollBar computeWidth) @ (adapter circleButtonSize)))
	]
]

{ #category : #initialization }
GLMPagerBarMorph >> initialize [
	super initialize.
		
	self 
		beTransparent
		changeProportionalLayout;
		borderWidth: 0.
	self
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> onPagePoped [

	buttons onPagePoped.
	self recomputeScrollBar.
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> onPagePushed: addedAnnouncement [

	buttons onPagePushed: addedAnnouncement.
	self recomputeScrollBar.
]

{ #category : #initialization }
GLMPagerBarMorph >> recomputeScrollBar [
	
	scrollBar ifNotNil: [
		scrollBar width: scrollBar computeWidth.
		scrollBar setWidthAfterResizing.
	]
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> width [
	^ buttons width
]
