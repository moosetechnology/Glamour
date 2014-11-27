Class {
	#name : #GLMBrickVerticalStackLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout class >> example [

	|foundationBrick rootBrick brick1 brick2 brick3 generator|	
	
	rootBrick := GLMBrick new.
	rootBrick layoutPolicy: self new.
	rootBrick color: Color white.
	
	brick1 := GLMLabelBrick new.
	brick1 height: 50.
	brick1 color: Color red.
	
	brick2 := GLMLabelBrick new.
	brick2 color: Color green.
	brick1 height: 50.
	
	brick3 := GLMLabelBrick new.
	brick3 color: Color yellow.
	brick1 height: 50.
	
	
	generator:= [
		1 to: 8 do: [ :index | |brick|
			brick := GLMLabelBrick new.
			brick color: (Color random alpha: 0.2).
			brick height: 30.
			rootBrick addBrickBack: brick ] ].
	
	rootBrick addBrickBack: brick1.
	generator value.
	
	rootBrick addBrickBack: brick2.
	generator value.
	
	rootBrick addBrickBack: brick3.
	generator value.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick extent: 400@400.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.

]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> gatherStacked: aBrick [
	|list|
	
	list := DoubleLinkedList new.
	aBrick subbricks do: [ :each | each layoutProperties floating = #stack ifTrue: [ list add: each ] ].
	^ list
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> isAbove: aBrick in: aRectangle [

	^ aBrick globalBounds origin <= aRectangle origin
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> isVisible: aBrick in: aRectangle [

	^ aRectangle containsRect: aBrick globalBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> layout: aBrick in: newBounds [
	
	super layout: aBrick in: newBounds.
	
	self layoutStacked: aBrick in: newBounds.
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> layoutStacked: aBrick in: newBounds [
	|topStackHeight bottomStackHeight stackedBricks allowedBounds forward|

	allowedBounds := newBounds.
	topStackHeight := 0.
	bottomStackHeight := 0.
	stackedBricks := self gatherStacked: aBrick.
	forward := true.
	
	"going from top to bottom"
	[ stackedBricks isEmpty not & forward] whileTrue: [ |brick|
		brick := stackedBricks removeFirst value.
		(self isVisible: brick in: allowedBounds) ifFalse: [
			(self isAbove: brick in: allowedBounds ) ifTrue: [ |delta|
				delta := topStackHeight + allowedBounds origin y - brick brickOuterBounds origin y.
				brick brickBounds: (brick brickBounds translateBy: (0@delta)).
				brick layoutProperties zIndex: 2.
				topStackHeight := topStackHeight + brick brickOuterBounds height.
				allowedBounds := allowedBounds top: (allowedBounds top + brick brickOuterBounds height)
			] ifFalse: [ forward := false. stackedBricks addFirst: brick ]
		] ifTrue: [ forward := false. brick layoutProperties zIndex: 1. ] ].

	"going from bottom to top"
	[ stackedBricks isEmpty not ] whileTrue: [ |brick|
		brick := stackedBricks removeLast value.
		(self isVisible: brick in: allowedBounds) ifFalse: [ |delta|
			delta := bottomStackHeight + brick brickOuterBounds corner y -  allowedBounds corner y.
			brick brickBounds: (brick brickBounds translateBy: (0@delta) negated).
			brick layoutProperties zIndex: 2.
			bottomStackHeight := bottomStackHeight + brick brickOuterBounds height.
			allowedBounds := allowedBounds bottom: (allowedBounds bottom - brick brickOuterBounds height)
		] ifTrue: [ brick layoutProperties zIndex: 1 ] ].

]
