Class {
	#name : #GLMPagerBarMorph,
	#superclass : #Morph,
	#instVars : [
		'buttons',
		'scrollBar',
		'pagerModel'
	],
	#category : #'Glamour-Morphic-Pager-Morphic'
}

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addButtons [
	buttons ifNil: [
		buttons := pagerModel isDependenciesShown ifTrue: [ GLMPagerPaneDependencyButtonsMorph new ] ifFalse: [ GLMPagerPaneButtonsMorph new ].
		buttons pagerModel: pagerModel.
		self addMorph: buttons fullFrame: (0@0 extent: 1@1).
	]
	
]

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> addScrollBar [
	scrollBar ifNil: [
		scrollBar := GLMPagerScrollSlidingMorph new.
		scrollBar pagerModel: pagerModel.
		scrollBar height: pagerModel circleButtonSize.
		
		self addMorph: scrollBar fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 0 @ 0)
					offsets: (0 @ 0 corner: (scrollBar computeWidth) @ (pagerModel circleButtonSize)))
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

{ #category : #'as yet unclassified' }
GLMPagerBarMorph >> pagerModel: aModel [
	
	pagerModel := aModel.
	
	pagerModel announcer weak
		on: GLMPagePushed send: #onPagePushed: to: self.
		
	pagerModel announcer weak
		on: GLMPagePoped send: #onPagePoped to: self.
	
	self addButtons.
	self addScrollBar.
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
