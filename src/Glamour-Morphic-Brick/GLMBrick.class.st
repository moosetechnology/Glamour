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
GLMBrick class >> openInWindow [

	^ GLMFoundationBrick new
		root: self new;
		openInWindow;
		yourself
	
]

{ #category : #'as yet unclassified' }
GLMBrick class >> openInWorld [

	^ GLMFoundationBrick new
		extent: 200@50;
		root: self new;
		openInWorld;
		yourself
	
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
	
	aBrick brickRoot: self brickRoot.
	aBrick brickOwner: self.
	
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

	brickBounds := (aRectangle origin + ((self layoutProperties paddingLeft) @ (self layoutProperties paddingTop)))
		corner: (aRectangle corner - ((self layoutProperties paddingRight) @ (self layoutProperties paddingBottom))).
	
	bounds := self bounds.
	fullBounds := bounds
]

{ #category : #geometry }
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
	
	self layoutPolicy layout: self in: self bounds.
	
	subbricks do: [ :each | each doLayout ]
	
]

{ #category : #drawing }
GLMBrick >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	"translating canvas coordinates"
	self onDraw: ( aCanvas copy setOrigin: (aCanvas origin + self globalBounds origin - self brickBounds origin) clipRect: aCanvas privateClipRect)
]

{ #category : #drawing }
GLMBrick >> drawSubmorphsOn: aCanvas [
	|  area outerBounds |
	
	submorphs isEmpty ifTrue: [ ^ self ].

	area := aCanvas clipRect.
	"do smart drawing logic here"
	area width = 0 | (area height = 0) ifTrue: [ 
			"draw nothing"
			^ self ].
	
	outerBounds := self brickGlobalOuterBounds.
	subbricks
		do: [ :each | 
			| intersection canvas  |
			intersection := area intersect: each globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
			canvas := aCanvas copyClipRect: intersection.
			each fullDrawOn: canvas ]
]

{ #category : #drawing }
GLMBrick >> extent [

	^ self brickBounds extent
]

{ #category : #geometry }
GLMBrick >> extent: aPoint [
	
	self brickBounds: (self brickBounds origin corner: aPoint)
]

{ #category : #geometry }
GLMBrick >> globalBounds [

	^ self brickOwner ifNotNil: [ self brickBounds translateBy: brickOwner globalBounds origin ] ifNil: [ 0@0 extent: 20@20 ].
]

{ #category : #geometry }
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
GLMBrick >> relativeBounds [

	^ self brickBounds translateBy: brickOwner relativeBounds origin
]

{ #category : #adding }
GLMBrick >> removeAllBricks [

	subbricks do: [ :each |
		each brickRoot: nil.
		each brickOwner: nil ].
	
	subbricks removeAll.
	self removeAllMorphs
]

{ #category : #adding }
GLMBrick >> removeBrick: aBrick [

	aBrick brickRoot: nil.
	aBrick brickOwner: nil.
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
