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
	#name : #GLMOldBrick,
	#superclass : #GLMBrickedMorph,
	#instVars : [
		'renderer',
		'data',
		'brickBounds',
		'brickOwner',
		'brickRoot',
		'subbricks',
		'backgroundColor'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #adding }
GLMOldBrick >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #adding }
GLMOldBrick >> addBrick: aBrick before: anotherBrick [
	|link|
	
	link := self privateSubbricks add: aBrick beforeLink: anotherBrick brickDoubleLink.
	aBrick brickDoubleLink: link.
	self initializeBrick: aBrick.
	super addMorph: aBrick inFrontOf: anotherBrick.
	^ aBrick
]

{ #category : #adding }
GLMOldBrick >> addBrickBack: aBrick [
	|link|
	
	link := self privateSubbricks add: aBrick.
	aBrick brickDoubleLink: link.
	
	self initializeBrick: aBrick.
	super addMorphBack: aBrick.
	^ aBrick
]

{ #category : #converting }
GLMOldBrick >> asBrick [
	^ self
]

{ #category : #converting }
GLMOldBrick >> asBrickedMorph [

	^ GLMFoundationBrick new brickRoot: self
]

{ #category : #geometry }
GLMOldBrick >> bounds [

	^ self globalBounds
]

{ #category : #geometry }
GLMOldBrick >> bounds: newBounds [

	self brickBounds: (
		self brickOwner
			ifNotNil: [ newBounds translateBy: (self brickOwner globalBounds origin negated) ]
			ifNil: [ newBounds ] )
]

{ #category : #geometry }
GLMOldBrick >> brickBounds [
	^ brickBounds
]

{ #category : #geometry }
GLMOldBrick >> brickBounds: aRectangle [
	"if you want to change brick's position or bounds use only this method!"
	brickBounds := aRectangle.
	
	bounds := self bounds.
	fullBounds := bounds.
]

{ #category : #private }
GLMOldBrick >> brickGlobalInnerBounds [

	^ self brickOwner
		ifNotNil: [ self brickInnerBounds translateBy: brickOwner globalBounds origin ]
		ifNil: [ super bounds ]
]

{ #category : #private }
GLMOldBrick >> brickGlobalOuterBounds [

	^ self brickOwner
		ifNotNil: [ self brickOuterBounds translateBy: brickOwner globalBounds origin ]
		ifNil: [ super bounds ]

]

{ #category : #geometry }
GLMOldBrick >> brickInnerBounds [

	^ (self brickBounds origin + ((self layoutProperties paddingLeft) @ (self layoutProperties paddingTop)))
		corner: (self brickBounds corner - ((self layoutProperties paddingRight) @ (self layoutProperties paddingBottom))).
]

{ #category : #geometry }
GLMOldBrick >> brickOuterBounds [

	^ (self brickBounds origin - ((self layoutProperties marginLeft) @ (self layoutProperties marginTop)))
		corner: (self brickBounds corner + ((self layoutProperties marginRight) @ (self layoutProperties marginBottom))).


]

{ #category : #accessing }
GLMOldBrick >> brickOwner [
	^ brickOwner
]

{ #category : #private }
GLMOldBrick >> brickOwner: aBrick [
	"never ever use this method"
	
	brickOwner := aBrick
]

{ #category : #accessing }
GLMOldBrick >> brickRoot [

	^ brickRoot
]

{ #category : #private }
GLMOldBrick >> brickRoot: aGLMFoundationBrick [
	"never ever use this method"
	
	brickRoot := aGLMFoundationBrick.
	
	self subbricks do: [ :each | each isBrick ifTrue: [ each brickRoot: brickRoot ] ]
]

{ #category : #drawing }
GLMOldBrick >> changed [
	"Report that the area occupied by this morph should be redrawn.
	Fixed to include submorphs outside the outerBounds."
	
	"fixed direct reference to fullBounds, causing wrong results, because fullBounds are not being updated when parent's or child's bounds changed"
	^ self fullBounds 
		ifNil: [self invalidRect: self privateFullBounds]
		ifNotNil: [self invalidRect: self fullBounds]
]

{ #category : #accessing }
GLMOldBrick >> color [

	^ backgroundColor ifNil: [ backgroundColor := Color transparent ]
]

{ #category : #accessing }
GLMOldBrick >> color: aColor [

	backgroundColor := aColor
]

{ #category : #accessing }
GLMOldBrick >> data [

	^ data
]

{ #category : #accessing }
GLMOldBrick >> data: anObject [
	data := anObject.
	
	self announcer announce: GLMBrickDataChanged new.
]

{ #category : #'layout brick' }
GLMOldBrick >> doLayout [
	"most of the time you don't want to call this method manually"
	"nice example to check is GLMLabelBrick>>doLayout"
	
	self layoutPolicy layout: self in: self bounds.
	
	subbricks do: [ :each | each isBrick ifTrue: [ each doLayout ] ]
	
]

{ #category : #drawing }
GLMOldBrick >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	"translating canvas coordinates"
	 (aCanvas isKindOf: ClippingCanvas) ifTrue: [ ^self "no need to draw anything" ].
	self onDraw: ( aCanvas copy setOrigin: (aCanvas origin + self globalBounds origin - self brickBounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #drawing }
GLMOldBrick >> drawSubmorphsOn: aCanvas [
	| area zIndexedBricks |
	
	self submorphs isEmpty ifTrue: [ ^ self ].

	"make sure my children will not go away of my inner bounds (we take care about paddings)"
	area := aCanvas clipRect intersect: self brickGlobalInnerBounds ifNone: (0 @ 0 extent: 0 @ 0).
	"do smart drawing logic here"
	area width = 0 | (area height = 0) ifTrue: [ 
			"draw nothing"
			^ self ].
	
	zIndexedBricks := OrderedCollection new.
	
	self subbricks
		do: [ :each | 
			| intersection canvas globalBounds |
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
				
			(area intersects: globalBounds) ifTrue: [
				| zIndex |
				zIndex := each layoutProperties zIndex.
				zIndex = 1 ifTrue: [
					"immediately draw ones with the lowest possible z-index.
					With this approach performance doesn't degrade"
					intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
					canvas := aCanvas copyClipRect: intersection.
					each fullDrawOn: canvas ]
					"if z-index is not 1 we add it to collection, in order to sort and draw as second attempt"
				ifFalse: [ zIndexedBricks add: each ] ] ].
		
		"z-index drawing section"
		zIndexedBricks sort: [ :first :second | first layoutProperties zIndex < second layoutProperties zIndex ].
		
		zIndexedBricks do: [ :each |
			| intersection canvas globalBounds |
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
				
			intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
			canvas := aCanvas copyClipRect: intersection.
			each fullDrawOn: canvas ]
		
]

{ #category : #drawing }
GLMOldBrick >> extent [

	^ self brickBounds extent
]

{ #category : #geometry }
GLMOldBrick >> extent: aPoint [
	"to change brick's size use only this method!"
	
	self brickBounds: (self brickBounds origin extent: aPoint)
]

{ #category : #'submorphs-accessing' }
GLMOldBrick >> firstSubbrick [

	^ self subbricks first
]

{ #category : #'layout morph' }
GLMOldBrick >> fullBounds [

	^ self globalBounds
]

{ #category : #drawing }
GLMOldBrick >> fullDrawOn: aCanvas [
	"fixes bug in canvas, when it tries to draw a morph even if clip rect has size 0"
	aCanvas clipRect width = 0 | (aCanvas clipRect height = 0) ifTrue: [ ^ self ].
	super fullDrawOn: aCanvas.
]

{ #category : #geometry }
GLMOldBrick >> globalBounds [
	"converts brickBounds to morhic bounds on fly"
	"if you want to implement something sophisticated that combines bricks and morphic this is right method to use"
	^ self brickOwner ifNotNil: [ self brickBounds translateBy: self brickOwner privateGlobalBoundsTranslateFactor ] ifNil: [ 0@0 extent: 20@20 ].
]

{ #category : #private }
GLMOldBrick >> globalBoundsTranslateFactor [

	^ self brickOwner ifNotNil: [ brickOwner privateGlobalBoundsTranslateFactor + self brickBounds origin ] ifNil: [ 0@0 ]
]

{ #category : #testing }
GLMOldBrick >> hasSubbrick: aBrick [

	^ aBrick owner = self
]

{ #category : #geometry }
GLMOldBrick >> height [

	^ self heightBlock
		ifNotNil: [ self heightBlock cull: self ]
		ifNil: [ self privateHeight ]
]

{ #category : #geometry }
GLMOldBrick >> height: aNumberOrBlockOrSymbol [

	(aNumberOrBlockOrSymbol isBlock | aNumberOrBlockOrSymbol isSymbol)
		ifTrue: [ self heightBlock: aNumberOrBlockOrSymbol ]
		ifFalse: [ super height: aNumberOrBlockOrSymbol ]
	
	
]

{ #category : #accessing }
GLMOldBrick >> heightBlock [

	^ self valueOfProperty: #brickHeightBlock ifAbsentPut: [ nil ]
]

{ #category : #accessing }
GLMOldBrick >> heightBlock: aBlock [
	"you can use a block to 'fake' a height or replace it's calculation logic without extending a brick"
	self setProperty: #brickHeightBlock toValue: aBlock
]

{ #category : #initialization }
GLMOldBrick >> initialize [
	super initialize.
	super color: Color transparent.
	
	subbricks := GLMBrickDoubleLinkedList new.
	
	self layoutProperties: GLMBrickLayoutProperties new.
	self layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	self renderer: GLMBrickRenderer new.
	self brickRoot: self.
	
	brickBounds := 0@0 extent: 50@50.
	
	self beTransparent
]

{ #category : #initialization }
GLMOldBrick >> initializeBrick: aBrick [
	
	aBrick isBrick ifTrue: [
		aBrick brickRoot: self brickRoot.
		aBrick brickOwner: self ]
]

{ #category : #testing }
GLMOldBrick >> isBrick [
	^ true
]

{ #category : #testing }
GLMOldBrick >> isFirstInOwner [

	^ self brickDoubleLink hasPredecessor not
]

{ #category : #testing }
GLMOldBrick >> isFitsInParent [

	^ self brickOwner
		"if our owner is a trick"
		ifNotNil: [ self brickOwner globalBounds containsRect: self globalBounds ]
		"if our owner is a morph"
		ifNil: [ self owner ifNotNil: [ self owner bounds containsRect: self globalBounds ] ifNil: [ ^ true ] ]
]

{ #category : #testing }
GLMOldBrick >> isLastInOwner [

	^ self brickDoubleLink hasSuccessor not
]

{ #category : #'submorphs-accessing' }
GLMOldBrick >> lastSubbrick [

	^ self subbricks last
]

{ #category : #'layout-properties' }
GLMOldBrick >> layout [
	"alias for layoutProperties"
	^ self layoutProperties
]

{ #category : #'layout-properties' }
GLMOldBrick >> layoutProperties: newProperties [
	super layoutProperties: newProperties.
	self layoutProperties brick: self
]

{ #category : #'layout brick' }
GLMOldBrick >> margin: aCssMarginFormat [
	"for format description see GLMBrickLayoutProperties>>margin:"
	self layoutProperties margin: aCssMarginFormat
]

{ #category : #accessing }
GLMOldBrick >> morph [
	^ self
]

{ #category : #drawing }
GLMOldBrick >> onDraw: aCanvas [

	self renderer render: self on: aCanvas. 
]

{ #category : #'layout brick' }
GLMOldBrick >> onLayoutEvent: aLayoutEvent [
	"in case layout want's to trigger any specific event"
]

{ #category : #'layout brick' }
GLMOldBrick >> onPrepareLayout [
	"is called before I'm started layouting"
]

{ #category : #'layout brick' }
GLMOldBrick >> padding: aCssPaddingFormat [
	"for format description see GLMBrickLayoutProperties>>padding:"
	self layoutProperties padding: aCssPaddingFormat
]

{ #category : #private }
GLMOldBrick >> privateGlobalBoundsTranslateFactor [

	^ self brickOwner ifNotNil: [ brickOwner privateGlobalBoundsTranslateFactor + self brickBounds origin ] ifNil: [ 0@0 ]
]

{ #category : #private }
GLMOldBrick >> privateHeight [

	^ self brickBounds height
]

{ #category : #private }
GLMOldBrick >> privateSubbricks [
	^ subbricks
]

{ #category : #private }
GLMOldBrick >> privateWidth [

	^ self brickBounds width
]

{ #category : #adding }
GLMOldBrick >> removeAllBricks [

	self privateSubbricks do: [ :each |
		each brickDoubleLink: nil.
		each isBrick ifTrue: [
			each brickRoot: nil.
			each brickOwner: nil ] ].
	
	self privateSubbricks removeAll.
	self removeAllMorphs
]

{ #category : #'submorphs-add/remove' }
GLMOldBrick >> removeAllMorphs [
	| oldMorphs myWorld |
	"we don't invalidate world"
	myWorld := self world.
	submorphs do: [:m | myWorld ifNotNil: [ m outOfWorld: myWorld ]. m privateOwner: nil].
	oldMorphs := submorphs.
	submorphs := EmptyArray.
	oldMorphs do: [ :m | self removedMorph: m ].

]

{ #category : #adding }
GLMOldBrick >> removeBrick: aBrick [
	
	aBrick isBrick ifTrue: [
		aBrick brickRoot: nil.
		aBrick brickOwner: nil.
	].
	
	self removeMorph: aBrick.
	self privateSubbricks removeLink: aBrick brickDoubleLink.
	aBrick brickDoubleLink: nil.
	^ aBrick
]

{ #category : #accessing }
GLMOldBrick >> renderer [

	^ renderer
]

{ #category : #accessing }
GLMOldBrick >> renderer: aRenderer [

	renderer := aRenderer
]

{ #category : #accessing }
GLMOldBrick >> subbricks [

	^ subbricks
]

{ #category : #accessing }
GLMOldBrick >> subbricksCount [

	^ self submorphCount
]

{ #category : #'submorphs-accessing' }
GLMOldBrick >> submorphAfter [

	"Return the submorph after (behind) me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link nextLink ifNil: [ ^ nil ].
	^ link nextLink value
]

{ #category : #'submorphs-accessing' }
GLMOldBrick >> submorphBefore [

	"Return the submorph before me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link previousLink ifNil: [ ^ nil ].
	^ link previousLink value
]

{ #category : #geometry }
GLMOldBrick >> width [

	^ self widthBlock
		ifNotNil: [ self widthBlock cull: self ]
		ifNil: [ self privateWidth ]
]

{ #category : #geometry }
GLMOldBrick >> width: aNumberOrBlockOrSymbol [

	(aNumberOrBlockOrSymbol isBlock | aNumberOrBlockOrSymbol isSymbol)
		ifTrue: [ self widthBlock: aNumberOrBlockOrSymbol ]
		ifFalse: [ super width: aNumberOrBlockOrSymbol ]
]

{ #category : #accessing }
GLMOldBrick >> widthBlock [

	^ self valueOfProperty: #brickWidthBlock ifAbsentPut: [ nil ]
]

{ #category : #accessing }
GLMOldBrick >> widthBlock: aBlock [
	"you can use a block to 'fake' a width or replace it's calculation logic without extending a brick"
	self setProperty: #brickWidthBlock toValue: aBlock
]
