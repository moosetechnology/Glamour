Class {
	#name : #GLMBrickVerticalStackLayout,
	#superclass : #GLMBrickVerticalFillLinearLayout,
	#instVars : [
		'allowedBounds'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout class >> example [
	"self example"
	|foundationBrick rootBrick brick1 brick2 brick3 brick4 brick5 brick6 generator|	
	
	rootBrick := GLMStackedScrollPaneBrick new.
	rootBrick band layoutPolicy: self new.
	rootBrick color: Color white.
	
	brick1 := GLMLabelBrick new.
	brick1 height: 30.
	brick1 text: 'Title 1'.
	brick1 textPosition: #center.
	brick1 layoutProperties floating: #stack.
	brick1 color: Color red.
	
	brick2 := GLMLabelBrick new.
	brick2 color: Color green.
	brick2 text: 'Title 2'.
	brick2 textPosition: #center.
	brick2 layoutProperties floating: #stack.
	brick2 height: 30.
	
	brick3 := GLMLabelBrick new.
	brick3 color: Color yellow.
	brick3 text: 'Title 3'.
	brick3 textPosition: #center.
	brick3 layoutProperties floating: #stack.
	brick3 height: 30.
	
	brick4 := GLMLabelBrick new.
	brick4 height: 30.
	brick4 text: 'Title 4'.
	brick4 textPosition: #center.
	brick4 layoutProperties floating: #stack.
	brick4 color: Color pink.
	
	brick5 := GLMLabelBrick new.
	brick5 color: Color orange.
	brick5 text: 'Title 5'.
	brick5 textPosition: #center.
	brick5 layoutProperties floating: #stack.
	brick5 height: 30.
	
	brick6 := GLMLabelBrick new.
	brick6 color: Color purple.
	brick6 text: 'Title 6'.
	brick6 textPosition: #center.
	brick6 layoutProperties floating: #stack.
	brick6 height: 30.
	
	generator:= [
		1 to: 10 do: [ :index | |brick|
			brick := GLMLabelBrick new.
			brick color: (Color random alpha: 0.2).
			brick height: 30.
			brick text: 'item',index asString.
			rootBrick addBrickBack: brick ] ].
	
	rootBrick addBrickBack: brick1.
	generator value.
	
	rootBrick addBrickBack: brick2.
	generator value.
	
	rootBrick addBrickBack: brick3.
	generator value.
	
	rootBrick addBrickBack: brick4.
	generator value.
	
	rootBrick addBrickBack: brick5.
	generator value.
	
	rootBrick addBrickBack: brick6.
	generator value.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick extent: 400@400.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.

]

{ #category : #accessing }
GLMBrickVerticalStackLayout >> allowedBounds [
	^ allowedBounds
]

{ #category : #accessing }
GLMBrickVerticalStackLayout >> allowedBounds: anObject [
	allowedBounds := anObject
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> cutAllowedBoundsBottom: aBrick [

	self allowedBounds: (self shrinkBottom: self allowedBounds with: aBrick )
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> cutAllowedBoundsTop: aBrick [

	self allowedBounds: (self shrinkTop: self allowedBounds with: aBrick )
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> decreaseZindex: aBrick [

	aBrick layoutProperties zIndex: 1.
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> deltaBottom: aBrick [

	^ aBrick brickGlobalOuterBounds corner y -  self allowedBounds corner y
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> deltaTop: aBrick [

	^ self allowedBounds origin y - aBrick brickGlobalOuterBounds origin y
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> gatherStacked: aBrick [
	|list|
	
	list := DoubleLinkedList new.
	aBrick subbricks do: [ :each | each layoutProperties floating = #stack ifTrue: [ list add: each ] ].
	^ list
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> increaseZindex: aBrick [

	aBrick layoutProperties zIndex: 2.
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isAbove: aBrick [

	^ aBrick brickGlobalOuterBounds origin <= self allowedBounds origin
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isAbove: aBrick in: aRectangle [

	^ aBrick brickGlobalOuterBounds origin <= aRectangle origin
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isVisible: aBrick [
	
	^ self allowedBounds containsRect: aBrick brickGlobalOuterBounds
]

{ #category : #testing }
GLMBrickVerticalStackLayout >> isVisible: aBrick in: aRectangle [
	
	^ aRectangle containsRect: aBrick brickGlobalOuterBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> layout: aBrick in: newBounds [
	
	super layout: aBrick in: newBounds.
	^ self layoutStacked: aBrick in: newBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> layoutStacked: aBrick in: newBounds [
	| stackedBricks forward|

	self allowedBounds: newBounds.
	stackedBricks := self gatherStacked: aBrick.
	forward := true.
	
	"going from top to bottom"
	[ stackedBricks isEmpty not & forward] whileTrue: [ |brick|
		brick := stackedBricks first value.
		(self isVisible: brick) ifFalse: [
			(self isAbove: brick) ifTrue: [ |delta|
				delta := self deltaTop: brick.
				self
					translate: brick by: delta;
					increaseZindex: brick;
					cutAllowedBoundsTop: brick.
				stackedBricks removeFirst.
			] ifFalse: [ forward := false ]
		] ifTrue: [ forward := false. self decreaseZindex: brick ] ].

	"going from bottom to top"
	[ stackedBricks isEmpty not ] whileTrue: [ |brick|
		brick := stackedBricks removeLast value.
		(self isVisible: brick) ifFalse: [ |delta|
			delta := self deltaBottom: brick.
			self
				translate: brick by: delta negated;
				increaseZindex: brick;
				cutAllowedBoundsBottom: brick.
		] ifTrue: [ self decreaseZindex: brick ] ].

	^ allowedBounds
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> shrinkBottom: aRectangle with: aBrick [

	^ aRectangle bottom: (aRectangle bottom - aBrick brickGlobalOuterBounds height)
]

{ #category : #'as yet unclassified' }
GLMBrickVerticalStackLayout >> shrinkTop: aRectangle with: aBrick [

	^ aRectangle top: (aRectangle top + aBrick brickGlobalOuterBounds height)
]
