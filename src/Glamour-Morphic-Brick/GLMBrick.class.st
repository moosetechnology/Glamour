"
A GLMBrick is xxxxxxxasdadxx.

Instance Variables
	brickBounds:		<Object>
	transmissions:		<Object>

brickBounds
	- xxxxx

transmissions
	- xxxxx

"
Class {
	#name : #GLMBrick,
	#superclass : #GLMBrickedMorph,
	#traits : 'GLMBrickPropertiesTrait + GLMBrickGeometryTrait + GLMBrickLayoutTrait + GLMBrickStructureTrait + GLMPhlowTrait',
	#classTraits : 'GLMBrickPropertiesTrait classTrait + GLMBrickGeometryTrait classTrait + GLMBrickLayoutTrait classTrait + GLMBrickStructureTrait classTrait + GLMPhlowTrait classTrait',
	#instVars : [
		'#brickBounds => GLMPhlowSlot',
		'#ports => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMBrick class >> exampleWithMorphInsideBrick [

	"self exampleWithMorphInsideBrick"

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

{ #category : #examples }
GLMBrick class >> exampleZindex [

	"self exampleZindex"

	|foundationBrick rootBrick brick1 brick2 brick3|
	
	rootBrick := GLMBrick new.
	rootBrick layoutPolicy: GLMBrickNoLayout new.

	rootBrick color: Color blue.
	
	brick1 := GLMBrick new.
	brick1 color: Color red.
	brick1 brickBounds: (0@0 extent: 300@200).
	brick1 layoutProperties zIndex: 1.
	
	brick2 := GLMBrick new.
	brick2 color: Color green.
	brick2 brickBounds: (50@50 extent: 200@100).
	brick2 layoutProperties zIndex: 2.
	
	brick3 := GLMBrick new.
	brick3 color: Color yellow.
	brick3 brickBounds: (100@100 extent: 100@100).
	brick3 layoutProperties zIndex: 3.
	
	rootBrick
		addBrickBack: brick3;
		addBrickBack: brick2;
		addBrickBack: brick1.
		
	foundationBrick := GLMFoundationBrick new.
	foundationBrick brickRoot: rootBrick.
	foundationBrick openInWindow.
	foundationBrick color: Color pink.
]

{ #category : #utils }
GLMBrick class >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ GLMForm increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> addAllBricks: aCollection [

	aCollection do: [ :each | self addBrickBack: each ]
]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> addBrick: aBrick before: otherBrick [
	| brick link otherLink otherLinkPredeccessor|
	brick := aBrick asBrick.
	
	otherLink := otherBrick brickDoubleLink.
	otherLink = self firstSubbrick brickDoubleLink
		ifTrue: [ ^ self addBrickFirst: brick ].
		
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	otherLinkPredeccessor := otherLink previousLink.
	otherLink previousLink: link.
	link nextLink: otherLink.
	link previousLink: otherLinkPredeccessor.
	otherLinkPredeccessor nextLink: link.
	
	self subbricks add: brick before: otherBrick.
	
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> addBrickBack: aBrick [
	|link brick|
	
	brick := aBrick asBrick.
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	
	self hasSubbricks ifTrue: [
		self lastSubbrick brickDoubleLink nextLink: link.	
		link previousLink: self lastSubbrick brickDoubleLink.
	].
	
	self privateSubbricks: (self subbricks copyWith: brick).
	brick owner: self.
	
	^ aBrick
]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> addBrickFirst: aBrick [
	| link head tail brick|
	
	brick := aBrick asBrick.
	head := nil.
	tail := nil.
	self hasSubbricks ifTrue: [
		head := self firstSubbrick brickDoubleLink.
		tail := self lastSubbrick brickDoubleLink ].
	
	link := brick asDoubleLink.
	brick brickDoubleLink: link.
	link nextLink: head.
	head ifNotNil: [ head previousLink: link ].
	
	self privateSubbricks: (self subbricks copyWithFirst: brick).
	brick owner: self.
	
	^ aBrick
]

{ #category : #'phlow-transmissions' }
GLMBrick >> addTransmission: aTransmission from: aSlotSymbol [
 
	^ (self portOf: aSlotSymbol) addTransmission: aTransmission
]

{ #category : #'brick-structure-converting' }
GLMBrick >> asBrick [
	^ self
]

{ #category : #'brick-structure-converting' }
GLMBrick >> asBrickedMorph [

	^ GLMFoundationBrick new brickRoot: self
]

{ #category : #'brick-geometry' }
GLMBrick >> bounds [

	^ self globalBounds
]

{ #category : #'brick-geometry' }
GLMBrick >> brickBounds [

	^ brickBounds ifNil: [ brickBounds := 0@0 extent: 50@50 ]
]

{ #category : #'brick-geometry' }
GLMBrick >> brickBounds: aRectangle [
	"if you want to change brick's position or bounds use only this method!"
	self privateBounds: aRectangle.
	
	self
		updateWidth;
		updateHeight
]

{ #category : #'private-structure' }
GLMBrick >> brickDoubleLink [

	^ self valueOfProperty: #brickDoubleLink ifAbsentPut: [ nil ]
]

{ #category : #'private-structure' }
GLMBrick >> brickDoubleLink: aDoubleLink [

	self setProperty: #brickDoubleLink toValue: aDoubleLink
]

{ #category : #'brick-structure' }
GLMBrick >> brickRoot [

	^ self owner ifNotNil: [ self owner brickRoot ] ifNil: [ ^ self ]
]

{ #category : #'morph-drawing' }
GLMBrick >> changed [
	"Report that the area occupied by this morph should be redrawn.
	Fixed to include submorphs outside the outerBounds."
	
	"fixed direct reference to fullBounds, causing wrong results, because fullBounds are not being updated when parent's or child's bounds changed"
	^ self fullBounds 
		ifNil: [self invalidRect: self privateFullBounds]
		ifNotNil: [self invalidRect: self fullBounds]
]

{ #category : #'brick-properties' }
GLMBrick >> color [

	^ self valueOfProperty: #brickBackgroundColor ifAbsent: [ self themer backgroundColor ]
]

{ #category : #'brick-properties' }
GLMBrick >> color: aColor [

	self setProperty: #brickBackgroundColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrick >> data [

	^ self valueOfProperty: #brickDataObject ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrick >> data: anObject [

	^ self setProperty: #brickDataObject  toValue:  anObject
]

{ #category : #'brick-layout' }
GLMBrick >> doLayout [

	self layoutSubbricks.
	self subbricks do: [ :each | each doLayout ]
]

{ #category : #'morph-drawing' }
GLMBrick >> drawOn: aCanvas [
	super drawOn: aCanvas.
	
	"translating canvas coordinates"
	 (aCanvas isKindOf: ClippingCanvas) ifTrue: [ ^self "no need to draw anything" ].
	self onDraw: (aCanvas copy setOrigin: (aCanvas origin + self globalBounds origin - self brickBounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #'morph-drawing' }
GLMBrick >> drawSubmorphsOn: aCanvas [
	| area zIndexedBricks |
	
	self submorphs isEmpty ifTrue: [ ^ self ].

	"make sure my children will not go away of my inner bounds (we take care about paddings)"
	area := aCanvas clipRect intersect: self globalInnerBounds ifNone: (0 @ 0 extent: 0 @ 0).
	"do smart drawing logic here"
	area width = 0 | (area height = 0) ifTrue: [ 
			"draw nothing"
			^ self ].
	
	zIndexedBricks := OrderedCollection new.
	
	self subbricks
		do: [ :each | 
			| intersection canvas globalBounds |
			each ifNotNil: [ self flag: 'fix nil case'.
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
				ifFalse: [ zIndexedBricks add: each ] ] ] ].
		
		"z-index drawing section"
		zIndexedBricks sort: [ :first :second | first layoutProperties zIndex < second layoutProperties zIndex ].
		
		zIndexedBricks do: [ :each |
			| intersection canvas globalBounds |
			each ifNotNil: [ self flag: 'fix nil case'.
			globalBounds := each isBrick
				ifTrue: [ each globalBounds ]
				ifFalse: [ each fullBounds ].
				
			intersection := area intersect: globalBounds ifNone: (0 @ 0 extent: 0 @ 0).
			canvas := aCanvas copyClipRect: intersection.
			each fullDrawOn: canvas ] ]
		
]

{ #category : #'brick-geometry' }
GLMBrick >> extent [

	self
		updateWidth;
		updateHeight.
		
	^ self brickBounds extent
]

{ #category : #'brick-geometry' }
GLMBrick >> extent: aPoint [
	"actually works only if width or height are not custom"
	self brickBounds: (self brickBounds origin extent: aPoint)
]

{ #category : #'brick-structure' }
GLMBrick >> firstSubbrick [

	^ self subbricks first
]

{ #category : #'morph-common' }
GLMBrick >> fullBounds [

	^ self globalBounds
]

{ #category : #'morph-drawing' }
GLMBrick >> fullDrawOn: aCanvas [
	"fixes bug in canvas, when it tries to draw a morph even if clip rect has size 0"
	aCanvas clipRect width = 0 | (aCanvas clipRect height = 0) ifTrue: [ ^ self ].
	super fullDrawOn: aCanvas.
]

{ #category : #'brick-geometry' }
GLMBrick >> globalBounds [
	"converts local bounds to global bounds on fly"
	
	^ self owner ifNotNil: [ self brickBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self brickBounds ].
]

{ #category : #'private-geometry' }
GLMBrick >> globalBoundsTranslateFactor [

	^ self owner ifNotNil: [ self owner globalBoundsTranslateFactor + self brickBounds origin ] ifNil: [ 0@0 ]
]

{ #category : #'brick-geometry' }
GLMBrick >> globalInnerBounds [
	"converts local inner bounds to global inner bounds on fly"
	
	^ self owner ifNotNil: [ self innerBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self innerBounds ].
]

{ #category : #'brick-geometry' }
GLMBrick >> globalOuterBounds [
	"converts local outer bounds to global inner bounds on fly"
	
	^ self owner ifNotNil: [ self outerBounds translateBy: self owner globalBoundsTranslateFactor ] ifNil: [ self outerBounds ].
]

{ #category : #'brick-structure-testing' }
GLMBrick >> hasOwner [

	^ self owner isNotNil
]

{ #category : #'private-extension' }
GLMBrick >> hasProperty: aSymbol [ 
	
	^ super hasProperty: aSymbol
]

{ #category : #'brick-structure-testing' }
GLMBrick >> hasSubbrick: aBrick [

	^ aBrick owner = self
]

{ #category : #'brick-structure-testing' }
GLMBrick >> hasSubbricks [

	^ self subbricks isEmpty not
]

{ #category : #'brick-geometry' }
GLMBrick >> height [

	self updateHeight.
	^ self brickBounds height
]

{ #category : #'brick-geometry' }
GLMBrick >> height: anObject [
	
	self setProperty: #brickGeometryHeightLogic toValue: anObject.
	self updateHeight
]

{ #category : #initialization }
GLMBrick >> initialize [
	super initialize.
	color := Color transparent.
	submorphs := OrderedCollection new.
	
	self layoutProperties: GLMBrickLayoutProperties new.
	self layoutPolicy: GLMBrickHorizontalFillProportionalLinearLayout new.
	self renderer: GLMBrickRenderer new.
]

{ #category : #'brick-geometry' }
GLMBrick >> innerBounds [

	^ (self brickBounds origin + (self paddingLeft @ self paddingTop))
		corner: (self brickBounds corner - ((self paddingRight) @ (self paddingBottom))).
]

{ #category : #'brick-structure-testing' }
GLMBrick >> isBrick [

	^ true
]

{ #category : #'brick-properties-testing' }
GLMBrick >> isColorSet [

	^ self hasProperty: #brickBackgroundColor
]

{ #category : #'brick-structure-testing' }
GLMBrick >> isFirstInOwner [

	^ self brickDoubleLink hasPredecessor not
]

{ #category : #'brick-testing' }
GLMBrick >> isFitsInParent [

	^ self owner
		"if our owner is a brick"
		ifNotNil: [ self owner globalBounds containsRect: self globalBounds ]
		"if our owner is a morph"
		ifNil: [ self owner ifNotNil: [ self owner bounds containsRect: self globalBounds ] ifNil: [ ^ true ] ]
]

{ #category : #'private-geometry' }
GLMBrick >> isHeightCustom [

	^ (self valueOfProperty: #brickGeometryHeightLogic ifAbsentPut: [ nil ]) isNotNil
]

{ #category : #'brick-structure-testing' }
GLMBrick >> isLastInOwner [

	^ self brickDoubleLink hasSuccessor not
]

{ #category : #'private-geometry' }
GLMBrick >> isWidthCustom [

	^ (self valueOfProperty: #brickGeometryWidthLogic ifAbsentPut: [ nil ]) isNotNil
]

{ #category : #'brick-structure' }
GLMBrick >> lastSubbrick [

	^ self subbricks last
]

{ #category : #'brick-layout' }
GLMBrick >> layout [
	"Alias for layoutProperies"
	^ self layoutProperties
]

{ #category : #'brick-layout' }
GLMBrick >> layout: aLayout [
	"Alias for layoutPolicy:"
	self layoutPolicy: aLayout
]

{ #category : #'brick-layout' }
GLMBrick >> layoutPolicy [

	^ super layoutPolicy
]

{ #category : #'brick-layout' }
GLMBrick >> layoutPolicy: aLayout [
	
	super layoutPolicy: aLayout
]

{ #category : #'brick-layout' }
GLMBrick >> layoutProperties [
	
	^ super layoutProperties
]

{ #category : #'brick-layout' }
GLMBrick >> layoutProperties: aLayoutProperties [ 

	super layoutProperties: aLayoutProperties.
	self layoutProperties brick: self
]

{ #category : #'brick-layout' }
GLMBrick >> layoutSubbricks [

	self layoutPolicy layout: self in: self innerBounds
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> margin: aCollection [

	self layout margin: aCollection
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginBottom [

	^ self layout marginBottom
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginBottom: anObject [

	self layout marginBottom: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginLeft [

	^ self layout marginLeft
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginLeft: anObject [

	self layout marginLeft: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginRight [

	^ self layout marginRight
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginRight: anObject [

	self layout marginRight: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginTop [

	^ self layout marginTop
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> marginTop: anObject [

	self layout marginTop: anObject
]

{ #category : #'brick-structure-converting' }
GLMBrick >> morph [
	^ self
]

{ #category : #'brick-drawing' }
GLMBrick >> onDraw: aCanvas [

	self renderer render: self on: aCanvas. 
]

{ #category : #'brick-layout-events' }
GLMBrick >> onLayoutEvent: aLayoutEvent [
	"in case layout want's to trigger any specific event"
]

{ #category : #'brick-layout-events' }
GLMBrick >> onPrepareLayout [
	"is called before I'm started layouting"
]

{ #category : #'private-phlow' }
GLMBrick >> onSlotChanged: aSlot [

	(self portOf: aSlot name) transmit
]

{ #category : #'brick-properties-events' }
GLMBrick >> onThemerChanged [

	self changed
]

{ #category : #'brick-geometry' }
GLMBrick >> outerBounds [

	^ (self brickBounds origin - ((self marginLeft) @ (self marginTop)))
		corner: (self brickBounds corner + ((self marginRight) @ (self marginBottom)))
]

{ #category : #'brick-structure' }
GLMBrick >> owner [

	^ owner
]

{ #category : #'private-structure' }
GLMBrick >> owner: aBrick [

	self privateOwner: aBrick.
	aBrick
		ifNotNil: [ self themerChanged ]
		ifNil: [ self onRemoved ]
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> padding: aCollection [

	self layout padding: aCollection
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingBottom [

	^ self layout paddingBottom
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingBottom: anObject [

	self layout paddingBottom: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingLeft [

	^ self layout paddingLeft
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingLeft: anObject [

	self layout paddingLeft: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingRight [

	^ self layout paddingRight
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingRight: anObject [

	self layout paddingRight: anObject
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingTop [

	^ self layout paddingTop
]

{ #category : #'brick-geometry-properties' }
GLMBrick >> paddingTop: anObject [

	self layout paddingTop: anObject
]

{ #category : #'phlow-transmissions' }
GLMBrick >> portOf: aSlotSymbol [

	^ self ports at: aSlotSymbol ifAbsentPut: [ GLMPhlowPort new ]
]

{ #category : #'phlow-transmissions' }
GLMBrick >> ports [

	^ ports  ifNil: [ ports := Dictionary new ]
]

{ #category : #'private-geometry' }
GLMBrick >> privateBounds: aRectangle [
	
	brickBounds := aRectangle.
	bounds := self globalBounds.
	fullBounds := bounds.
]

{ #category : #'private-structure' }
GLMBrick >> privateOwner: aBrick [

	owner := aBrick
]

{ #category : #'private-structure' }
GLMBrick >> privateSubbricks: aCollection [

	submorphs := aCollection
]

{ #category : #'private-properties' }
GLMBrick >> privateThemer [

	^ self valueOfProperty: #brickThemer ifAbsentPut: [ nil ]
]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> removeAllBricks [

	self subbricks do: [:each |
		each brickDoubleLink: nil.
		each owner: nil ].
	self subbricks removeAll
]

{ #category : #'morph-common' }
GLMBrick >> removeAllMorphs [
	| oldMorphs myWorld |
	"we don't invalidate world"
	myWorld := self world.
	submorphs do: [:m | myWorld ifNotNil: [ m outOfWorld: myWorld ]. m privateOwner: nil].
	oldMorphs := submorphs.
	submorphs := EmptyArray.
	oldMorphs do: [ :m | self removedMorph: m ].

]

{ #category : #'brick-structure-adding/removing' }
GLMBrick >> removeBrick: aBrick [
	| predecessor successor link head tail index|
	
	link := aBrick brickDoubleLink.
	head := self firstSubbrick brickDoubleLink.
	tail := self lastSubbrick brickDoubleLink.
	
	predecessor := link previousLink.
	successor := link nextLink.
	predecessor
		ifNotNil: [ predecessor nextLink: successor ].
	successor
		ifNotNil: [ successor previousLink: predecessor ].
	link clearLinks.
	
	aBrick brickDoubleLink: nil.
	
	index := self subbricks find: aBrick.
	self privateSubbricks: (self subbricks copyWithoutIndex: index).
	aBrick owner: nil.
	
	^ aBrick
]

{ #category : #'private-extension' }
GLMBrick >> removeProperty: aSymbol [
	
	super removeProperty: aSymbol
]

{ #category : #'brick-properties' }
GLMBrick >> renderer [

	^ self valueOfProperty: #brickRenderer ifAbsentPut: [ nil ]
]

{ #category : #'brick-properties' }
GLMBrick >> renderer: aRenderer [

	self setProperty: #brickRenderer toValue: aRenderer
]

{ #category : #'private-extension' }
GLMBrick >> setProperty: aSymbol toValue: anObject [
	
	super setProperty: aSymbol toValue: anObject
]

{ #category : #'brick-properties' }
GLMBrick >> shadowColor [

	^ self valueOfProperty: #brickShadowColor ifAbsentPut: [ Color transparent ]
]

{ #category : #'brick-properties' }
GLMBrick >> shadowColor: aColor [

	self setProperty: #brickShadowColor toValue: aColor
]

{ #category : #'brick-properties' }
GLMBrick >> shadowWidth [

	^ self valueOfProperty: #brickShadowWidth ifAbsentPut: [ 0 ]
]

{ #category : #'brick-properties' }
GLMBrick >> shadowWidth: anInteger [

	self setProperty: #brickShadowWidth toValue: anInteger
]

{ #category : #'brick-structure' }
GLMBrick >> subbrickAfter [

	"Return the subbbrick after (behind) me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link nextLink ifNil: [ ^ nil ].
	^ link nextLink value
]

{ #category : #'brick-structure' }
GLMBrick >> subbrickBefore [

	"Return the subbrick before me, or nil"
	| link |
	link := self brickDoubleLink.
	link ifNil: [ ^ nil ].
	link previousLink ifNil: [ ^ nil ].
	^ link previousLink value
]

{ #category : #'brick-structure' }
GLMBrick >> subbricks [

	^ self submorphs
]

{ #category : #'brick-structure' }
GLMBrick >> subbricksCount [

	^ self subbricks size
]

{ #category : #'morph-common' }
GLMBrick >> submorphAfter [

	^ self subbrickAfter
]

{ #category : #'morph-common' }
GLMBrick >> submorphBefore [

	^ self subbrickBefore
]

{ #category : #'brick-properties' }
GLMBrick >> themer [

	^ self privateThemer
		ifNotNil: [ self privateThemer ]
		ifNil: [ self hasOwner
			ifTrue: [ self owner themer ]
			ifFalse: [ self theme brickThemer ] ]
]

{ #category : #'brick-properties' }
GLMBrick >> themer: aThemer [

	self setProperty: #brickThemer toValue: aThemer.
	self themerChanged
]

{ #category : #'brick-properties' }
GLMBrick >> themerChanged [

	self onThemerChanged.
	self subbricks do: #themerChanged
]

{ #category : #'brick-geometry-transformations' }
GLMBrick >> translateBy: aPoint [

	self brickBounds: (self brickBounds translateBy: aPoint)
]

{ #category : #'brick-geometry-transformations' }
GLMBrick >> translateX: anInteger [

	self translateBy: anInteger@0
]

{ #category : #'brick-geometry-transformations' }
GLMBrick >> translateY: anInteger [

	self translateBy: 0@anInteger
]

{ #category : #'phlow-scripting' }
GLMBrick >> transmit [

	^ GLMPhlowTransmissionBuilder phlow: self
]

{ #category : #'private-geometry' }
GLMBrick >> updateHeight [

	"no need to care about height, when it's logic is not customized"
	self isHeightCustom ifFalse: [ ^ self ].
	[ self privateBounds: (self brickBounds withHeight: ((self valueOfProperty: #brickGeometryHeightLogic) brickValue: self)) ]
		on: Exception
		do: [ "just skip and do nothing" ]
]

{ #category : #'private-geometry' }
GLMBrick >> updateWidth [

	"no need to care about width, when it's logic is not customized"
	self isWidthCustom ifFalse: [ ^ self ].
	[ self privateBounds: (self brickBounds withWidth: ((self valueOfProperty: #brickGeometryWidthLogic) brickValue: self)) ]
		on: Exception
		do: [ "just skip and do nothing" ]
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol [
	
	^ super valueOfProperty: aSymbol
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol ifAbsent: aBlock [
	
	^ super valueOfProperty: aSymbol ifAbsent: aBlock
]

{ #category : #'private-extension' }
GLMBrick >> valueOfProperty: aSymbol ifAbsentPut: aBlock [ 
	
	^ super valueOfProperty: aSymbol ifAbsentPut: aBlock
]

{ #category : #'brick-geometry' }
GLMBrick >> width [

	self updateWidth.
	^ self brickBounds width
]

{ #category : #'brick-geometry' }
GLMBrick >> width: anObject [

	self setProperty: #brickGeometryWidthLogic toValue: anObject.
	self updateWidth
]

{ #category : #'brick-geometry-transformations' }
GLMBrick >> withHeight: anInteger [

	self brickBounds: (self brickBounds withHeight: anInteger)
]

{ #category : #'brick-geometry-transformations' }
GLMBrick >> withWidth: anInteger [

	self brickBounds: (self brickBounds withWidth: anInteger)
]
