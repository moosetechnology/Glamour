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

{ #category : #'as yet unclassified' }
GLMFoundationBrick class >> exampleLarge [
	|foundation scrollPane|
	
	scrollPane := GLMScrollPaneBrick new.
	
	foundation := self new.
	foundation brickRoot: scrollPane.
	
	1 to: 10000 do: [ :index |
		scrollPane addBrickBack: (GLMBrick new
			color: Color random;
			extent: 200@50).
	].
	
	foundation extent: 400@300.
	
	foundation openInWindow
]

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
	|left top right bottom|
	
	super extent: aPoint.
	
	left := self brickRoot layoutProperties marginLeft.
	top := self brickRoot layoutProperties marginTop.
	
	right := self extent x - self brickRoot layoutProperties marginRight.
	bottom := self extent y - self brickRoot layoutProperties marginBottom.
	
	self brickRoot brickBounds: (left@top corner: (right@bottom)).
	
	self brickRoot doLayout.
]

{ #category : #drawing }
GLMFoundationBrick >> fullDrawOn: aCanvas [
	"preventing from drawing outside of me"
	super fullDrawOn: (aCanvas copyClipRect: self fullBounds).
]

{ #category : #geometry }
GLMFoundationBrick >> globalBounds [

	^ self bounds
]

{ #category : #geometry }
GLMFoundationBrick >> globalBoundsTranslateFactor [

	^ self globalBounds origin
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

{ #category : #private }
GLMFoundationBrick >> privateExtent: aPoint [

	super extent: aPoint.
]

{ #category : #geometry }
GLMFoundationBrick >> relativeBounds [

	^ 0@0 extent: self extent
]

{ #category : #adding }
GLMFoundationBrick >> removeAllBricks [

	self brickRoot removeAllBricks
]
