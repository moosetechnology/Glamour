"
A GLMBrick is the main Brick class. Can hold another Bricks and contains logic of rendering, positioning bricks and also possibilities to interate with them using mouse or keyboard.

The idea of this project is to boost  performance of complicated glamour widgets where smooth and fast work is neccessary.

Instance Variables
	data:		<Object>
	renderer:		<Object>
	subbricks:		<Object>
	brickBounds:		<Object>
	brickOwner:		<Object>
	brickRoot:		<Object>

data
	- xxxxx

renderer
	- xxxxx

subbricks
	- xxxxx

brickBounds
	- xxxxx

brickOwner
	- xxxxx

brickRoot
	- xxxxx

"
Class {
	#name : #GLMBrick,
	#superclass : #Morph,
	#instVars : [
		'renderer',
		'data',
		'brickBounds',
		'brickOwner',
		'brickRoot',
		'subbricks'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #'as yet unclassified' }
GLMBrick class >> morphInsideBrickExample [
	|foundation brick morph|
	
	foundation := GLMFoundationBrick new.
	foundation extent: 800@400.

	brick := GLMLabelBrick new.
	brick text: 'Hello, I''m a Brick inside another Brick!'.
	brick layoutProperties horizontalPercent: 50.
	brick color: Color lightBlue lighter.

	morph := Morph new.
	morph color: Color lightGreen lighter.
	morph layoutProperties: GLMBrickLayoutProperties new.
	morph layoutProperties horizontalPercent: 50.

	morph addMorphBack: (LabelMorph new
		contents: 'Hello, I''m a Morph inside another Morph inside Brick!';
		hResizing: #spaceFill;
		vResizing: #spaceFill).

	foundation
		addBrickBack: brick;
		addBrickBack: morph;
		doLayout;
		openInWindow.
]

{ #category : #'as yet unclassified' }
GLMBrick class >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ GLMForm increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #adding }
GLMBrick >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #adding }
GLMBrick >> addBrickBack: aBrick [

	subbricks add: aBrick.
	
	aBrick isBrick ifTrue: [
		aBrick brickRoot: self brickRoot.
		aBrick brickOwner: self.
	].
	
	super addMorphBack: aBrick.
	^ aBrick
]

{ #category : #geometry }
GLMBrick >> bounds [

	^ self globalBounds
]

{ #category : #geometry }
GLMBrick >> bounds: newBounds [

	self brickBounds: (
		self brickOwner
			ifNotNil: [ newBounds translateBy: (self brickOwner globalBounds origin negated) ]
			ifNil: [ newBounds ] )
]

{ #category : #geometry }
GLMBrick >> brickBounds [
	^ brickBounds
]

{ #category : #geometry }
GLMBrick >> brickBounds: aRectangle [
	"if you want to change brick's position or bounds use only this method!"
	
	brickBounds := (aRectangle origin + ((self layoutProperties paddingLeft) @ (self layoutProperties paddingTop)))
		corner: (aRectangle corner - ((self layoutProperties paddingRight) @ (self layoutProperties paddingBottom))).
	
	bounds := self bounds.
	fullBounds := bounds
]

{ #category : #private }
GLMBrick >> brickGlobalOuterBounds [

	^ self brickOwner
		ifNotNil: [ self brickOuterBounds translateBy: brickOwner globalBounds origin ]
		ifNil: [ super bounds ]

]

{ #category : #geometry }
GLMBrick >> brickOuterBounds [
	^ (self brickBounds origin - ((self layoutProperties paddingLeft) @ (self layoutProperties paddingTop)))
		corner: (self brickBounds corner + ((self layoutProperties paddingRight) @ (self layoutProperties paddingBottom))).


]

{ #category : #accessing }
GLMBrick >> brickOwner [
	^ brickOwner
]

{ #category : #private }
GLMBrick >> brickOwner: aBrick [
	"never ever use this method"
	
	brickOwner := aBrick
]

{ #category : #accessing }
GLMBrick >> brickRoot [

	^ brickRoot
]

{ #category : #private }
GLMBrick >> brickRoot: aGLMFoundationBrick [
	"never ever use this method"
	
	brickRoot := aGLMFoundationBrick.
	
	self subbricks do: [ :each | each brickRoot: brickRoot ]
]

{ #category : #drawing }
GLMBrick >> changed [
	"Report that the area occupied by this morph should be redrawn.
	Fixed to include submorphs outside the outerBounds."
	
	"fixed direct reference to fullBounds, causing wrong results, because fullBounds are not being updated when parent's or child's bounds changed"
	^ self fullBounds 
		ifNil: [self invalidRect: self privateFullBounds]
		ifNotNil: [self invalidRect: self fullBounds]
]

{ #category : #geometry }
GLMBrick >> clippingBounds [

	^ self fullBounds
]

{ #category : #geometry }
GLMBrick >> computeBounds [
	"nothing to compute, everything is already computed"
]

{ #category : #geometry }
GLMBrick >> computeFullBounds [
	"nothing to compute, everything is already computed"
]

{ #category : #accessing }
GLMBrick >> data [

	^ data
]

{ #category : #accessing }
GLMBrick >> data: anObject [
	data := anObject.
	
	self announcer announce: GLMBrickDataChanged new.
]

{ #category : #layouting }
GLMBrick >> doLayout [
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
	
	self layoutPolicy layout: self in: self bounds.
	
	subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
	
]

{ #category : #drawing }
GLMBrick >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	"translating canvas coordinates"
	self onDraw: ( aCanvas copy setOrigin: (aCanvas origin + self globalBounds origin - self brickBounds origin) clipRect: aCanvas privateClipRect)
]

{ #category : #drawing }
GLMBrick >> drawSubmorphsOn: aCanvas [
	|  area |
	
	submorphs isEmpty ifTrue: [ ^ self ].

	area := aCanvas clipRect.
	"do smart drawing logic here"
	area width = 0 | (area height = 0) ifTrue: [ 
			"draw nothing"
			^ self ].
	
	subbricks
		do: [ :each | 
			| intersection canvas globalBounds |
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
			
			intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
			canvas := aCanvas copyClipRect: intersection.
			each fullDrawOn: canvas ]
]

{ #category : #drawing }
GLMBrick >> extent [

	^ self brickBounds extent
]

{ #category : #geometry }
GLMBrick >> extent: aPoint [
	"to change brick's size use only this method!"
	
	self brickBounds: (self brickBounds origin extent: aPoint)
]

{ #category : #geometry }
GLMBrick >> fullBounds [

	^ self globalBounds
]

{ #category : #drawing }
GLMBrick >> fullDrawOn: aCanvas [
	"fixes bug in canvas, when it tries to draw a morph even if clip rect has size 0"
	aCanvas clipRect width = 0 | (aCanvas clipRect height = 0) ifTrue: [ ^ self ].
	super fullDrawOn: aCanvas.
]

{ #category : #geometry }
GLMBrick >> globalBounds [
	"converts brickBounds to morhic bounds on fly"
	"if you want to implement something sophisticated that combines bricks and morphic this is right method to use"
	^ self brickOwner ifNotNil: [ self brickBounds translateBy: brickOwner globalBounds origin ] ifNil: [ 0@0 extent: 20@20 ].
]

{ #category : #private }
GLMBrick >> globalBoundsOfArea: aRectangle [

	^ aRectangle translateBy: brickOwner globalBounds origin
	
]

{ #category : #geometry }
GLMBrick >> height [
	^ self brickBounds height + self layoutProperties paddingTop  + self layoutProperties paddingTop
]

{ #category : #initialization }
GLMBrick >> initialize [
	super initialize.
	
	subbricks := OrderedCollection new.
	
	self layoutProperties: GLMBrickLayoutProperties new.
	self layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	self renderer: GLMBrickRenderer.
	self brickRoot: self.
	
	brickBounds := 0@0 extent: 50@50.
	
	self beTransparent
]

{ #category : #testing }
GLMBrick >> isBrick [
	^ true
]

{ #category : #testing }
GLMBrick >> isFitsInParent [

	^ self brickOwner
		"if our owner is a trick"
		ifNotNil: [ self brickOwner globalBounds containsRect: self globalBounds ]
		"if our owner is a morph"
		ifNil: [ self owner ifNotNil: [ self owner bounds containsRect: self globalBounds ] ifNil: [ ^ true ] ]
]

{ #category : #drawing }
GLMBrick >> onDraw: aCanvas [

	self renderer render: self on: aCanvas. 
]

{ #category : #geometry }
GLMBrick >> outerBounds [
	^ self fullBounds
]

{ #category : #geometry }
GLMBrick >> privateFullBounds [
	^ self fullBounds
]

{ #category : #geometry }
GLMBrick >> relativeBounds [

	^ self brickBounds translateBy: brickOwner relativeBounds origin
]

{ #category : #adding }
GLMBrick >> removeAllBricks [

	subbricks do: [ :each |
		each isBrick ifTrue: [
			each brickRoot: nil.
			each brickOwner: nil ] ].
	
	subbricks removeAll.
	self removeAllMorphs
]

{ #category : #adding }
GLMBrick >> removeBrick: aBrick [
	
	aBrick isBrick ifTrue: [
		aBrick brickRoot: nil.
		aBrick brickOwner: nil.
	].
	
	self removeMorph: aBrick.
	subbricks remove: aBrick ifAbsent: [ ^ aBrick ].
	^ aBrick
]

{ #category : #accessing }
GLMBrick >> renderer [

	^ renderer
]

{ #category : #accessing }
GLMBrick >> renderer: aRenderer [

	renderer := aRenderer
]

{ #category : #accessing }
GLMBrick >> subbricks [

	^ subbricks
]

{ #category : #geometry }
GLMBrick >> width [

	^ self brickBounds width + self layoutProperties paddingLeft  + self layoutProperties paddingRight 
]
