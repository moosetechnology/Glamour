"
A GLMFoundationBrick is connection layer between brick widgets and morphic.

See GLMBrick class comment for more info.

Instance Variables
	brickRoot:		<Object>

brickRoot
	- xxxxx

"
Class {
	#name : #GLMFoundationBrick,
	#superclass : #Morph,
	#instVars : [
		'brickRoot'
	],
	#category : #'Glamour-Morphic-Brick-Widgets'
}

{ #category : #adding }
GLMFoundationBrick >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #adding }
GLMFoundationBrick >> addBrickBack: aBrick [

	self brickRoot addBrickBack: aBrick.
]

{ #category : #accessing }
GLMFoundationBrick >> brickRoot [

	^ brickRoot
]

{ #category : #accessing }
GLMFoundationBrick >> brickRoot: aBrick [

	self brickRoot ifNotNil: [
		self brickRoot brickOwner: nil.
		self brickRoot brickRoot: nil.
		self removeMorph: self brickRoot.
		brickRoot := nil.
	].
	
	brickRoot := aBrick.
	brickRoot brickOwner: self.
	brickRoot brickRoot: self.
	self addMorphBack: brickRoot.
	
	
]

{ #category : #layouting }
GLMFoundationBrick >> doLayout [

	self brickRoot doLayout.
]

{ #category : #geometry }
GLMFoundationBrick >> extent: aPoint [
	super extent: aPoint.
	
	self brickRoot brickBounds: (0@0 extent: self extent).
	self brickRoot doLayout.
]

{ #category : #geometry }
GLMFoundationBrick >> globalBounds [

	^ self bounds
]

{ #category : #initialization }
GLMFoundationBrick >> initialize [
	super initialize.
	
	self beTransparent.
	
	self brickRoot: GLMBrick new.
	self brickRoot layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
]

{ #category : #testing }
GLMFoundationBrick >> isFocused [

	^ false
]

{ #category : #geometry }
GLMFoundationBrick >> relativeBounds [

	^ 0@0 extent: self extent
]

{ #category : #adding }
GLMFoundationBrick >> removeAllBricks [

	self brickRoot removeAllBricks
]