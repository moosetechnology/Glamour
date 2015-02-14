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
	#traits : 'GLMBrickPropertiesTrait + GLMBrickLayoutTrait + GLMBrickStructureTrait + GLMPhlowTrait + (GLMBrickGeometryTrait - {#privateBounds:})',
	#classTraits : 'GLMBrickPropertiesTrait classTrait + GLMBrickGeometryTrait classTrait + GLMBrickLayoutTrait classTrait + GLMBrickStructureTrait classTrait + GLMPhlowTrait classTrait',
	#instVars : [
		'#brickBounds => GLMPhlowSlot',
		'#ports => GLMPhlowSlot'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #examples }
GLMBrick class >> exampleDynamicBorder [
	<example:'Dynamic border width'>
	
	(GLMLabelBrick new
		borderColor: Color blue; 
		borderWidth: [ :b | (b height min: b width) * 0.1 ];
		color: Color white;
		text: 'Resize me';
		fontSize: 12;
		textPosition: #center) asBrickedMorph openInWindow
]

{ #category : #examples }
GLMBrick class >> exampleWithMorphInsideBrick [

	"self exampleWithMorphInsideBrick"

	|foundation brick morph|
	
	foundation := GLMFoundationBrick new.
	foundation extent: 800@400.

	brick := GLMLabelBrick new.
	brick text: 'Hello, I''m a Brick inside another Brick!'.
	brick hSpaceFill: 50.
	brick color: Color lightBlue lighter.

	morph := Morph new.
	morph color: Color lightGreen lighter.
	morph layoutProperties: GLMBrickLayoutProperties new.
	morph hSpaceFill: 50.

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
GLMBrick class >> increaseFormExtentCentered: aForm to: aPoint [
	| icon rect destination |
	
	aForm ifNil: [ ^ nil ].
	rect := Rectangle origin: 0@0 extent: aPoint.
	destination := (rect extent - aForm extent) / 2.
	icon := Form extent: rect extent depth: aForm depth.
	icon copyBits: rect from: aForm at: destination clippingBox: icon boundingBox rule: Form over fillColor: nil.
	^ icon
]

{ #category : #utils }
GLMBrick class >> makeForm32Bit: aForm [
	aForm ifNil: [ ^ nil ].
	aForm depth = 32 ifTrue: [ ^ aForm ].
	aForm depth: 32.
	aForm fixAlpha.
	^ aForm.
]

{ #category : #utils }
GLMBrick class >> makeFormTransparent: aForm factor: aFloat [
	"a float must be in interval [0.0, 1.0]"
	| a |
	
	aForm ifNil: [ ^ nil ].
	aForm depth = 32 ifFalse: [^ aForm ].
	
	a := (aFloat * 255) asInteger.
	1 to: aForm bits size do: [:i |
		| v r g b |
		v := aForm bits at: i.
		r := ((v bitShift: -16) bitAnd: 255) * a // 255.
		g := ((v bitShift: -8) bitAnd: 255) * a // 255.
		b := (v bitAnd: 255) * a // 255.
		aForm bits at: i put: (a bitShift: 24) + (r bitShift: 16) + (g bitShift: 8) + b ].
	^ aForm 
]

{ #category : #utils }
GLMBrick class >> resizeImage: anImage scale: aScale [

	((aScale > (1@0)) | (aScale > (0@1))) ifTrue: [
		^ self increaseFormExtentCentered: anImage to: (anImage extent * aScale).
	].

	aScale = (1@1) ifTrue: [
		^ anImage
	].
	
	^ anImage magnify: anImage boundingBox by: aScale smoothing: 2.
]

{ #category : #utils }
GLMBrick class >> scaleForm: aForm by: aPoint [

	aForm ifNil: [ ^ nil ].
	^ aForm magnify: aForm boundingBox by: aPoint smoothing: 2
]

{ #category : #utils }
GLMBrick class >> scaleForm: aForm to: aPoint [
	|scaleX scaleY|
	
	aForm ifNil: [ ^ nil ].
	scaleX := aPoint x / aForm width.
	scaleY := aPoint y / aForm height.
	^ self scaleForm: aForm by: scaleX @ scaleY.
]

{ #category : #utils }
GLMBrick class >> scalePatchForm: aForm size: aPoint [
	"aPoint - width and height of new form
	
|form|

form := PatchForm scalePatchForm: (ImageReadWriter formFromFileNamed: 'abc_calculator_button_normal.p.png') size:800@800.
(ImageMorph withForm: form) openInWindow.

form := ImageReadWriter formFromFileNamed: 'abc_calculator_button_normal.png'.
form := PatchForm scaleForm: form by: (800/(form extent x))@(800/(form extent y)).
(ImageMorph withForm: form) openInWindow.
	
	"
	
	|x0 x1 y0 y1 width height newForm tmpForm color bottomHeight rightWidth newMiddleWidth newMiddleHeight|
	
	aForm ifNil: [ ^ nil ].
	
	color := Color red.
	x0 := x1 := y0 := y1 := 0.
	width := aForm extent x.
	height := aForm extent y.
	
	(0 to: width-1) collect: [ :each |
		(aForm colorAt: each@0) = color ifTrue: [ 
			x0 = 0 ifTrue: [ 
				x0 := each.
			]
		] ifFalse:[
			(x0 > 0 & x1 = 0) ifTrue:[
				x1 := each.
			].
		].
	].

	(0 to: height) collect: [ :each |
		(aForm colorAt: 0@each) = color ifTrue: [ 
			y0 = 0 ifTrue: [ 
				y0 := each.
			]
		] ifFalse:[
			(y0 > 0 & y1 = 0) ifTrue:[
				y1 := each.
			].
		].
	].

	rightWidth := width - x1 -1.
	bottomHeight := height - y1 - 1.
	newMiddleWidth := aPoint x - x0 - rightWidth + 1.
	newMiddleHeight := aPoint y - y0 - bottomHeight + 1.
	
	newForm := Form extent: aPoint depth: aForm depth.
	"left top corner"
	newForm copyBits: (1@1 corner: x0@y0)
		from: aForm at: 0@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"left bottom corner"
	newForm copyBits: (1@y1 corner: x0@(height - 1))
		from: aForm at: 0@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"right top corner"
	newForm copyBits: (x1@1 corner: (width-1)@y0)
		from: aForm at: (aPoint x - rightWidth)@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	"right bottom corner"
	newForm copyBits: (x1@y1 corner: (width - 1)@(height - 1))
		from: aForm at: (aPoint x - rightWidth)@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"top middle block"
	tmpForm := aForm copy: (x0@1 corner: x1@y0).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@1.
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@0 clippingBox: newForm boundingBox rule: Form over fillColor: nil.
		
	"bottom middle block"
	tmpForm := aForm copy: (x0@y1 corner: x1@height).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@1.
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@(aPoint y - bottomHeight) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"left middle block"
	tmpForm := aForm copy: (1@y0 corner: x0@y1).
	tmpForm := self scaleForm: tmpForm by: 1@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: 0@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	"right middle block"
	tmpForm := aForm copy: (x1@y0 corner: width@y1).
	tmpForm := self scaleForm: tmpForm by: 1@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (aPoint x - rightWidth)@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
		
	"middle block"
	tmpForm := aForm copy: (x0@y0 corner: x1@y1).
	tmpForm := self scaleForm: tmpForm by: ((newMiddleWidth)/(x1-x0))@((newMiddleHeight)/(y1-y0)).
	newForm copyBits: (0@0 corner: (tmpForm extent x)@(tmpForm extent y))
		from: tmpForm at: (x0-1)@(y0-1) clippingBox: newForm boundingBox rule: Form over fillColor: nil.
	
	^ newForm.
	

]

{ #category : #'brick-geometry' }
GLMBrick >> bounds [

	^ self globalBounds
]

{ #category : #'morph-common' }
GLMBrick >> boundsInWorld [

	^ self globalBounds
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

{ #category : #'morph-drawing' }
GLMBrick >> changedWith: aBlock [

	self changed.
	aBlock cull: self.
	self changed.
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

{ #category : #'private-extension' }
GLMBrick >> hasProperty: aSymbol [ 
	
	^ super hasProperty: aSymbol
]

{ #category : #initialization }
GLMBrick >> initialize [
	super initialize.
	color := Color transparent.
	submorphs := OrderedCollection new.
	
	self
		layoutProperties: GLMBrickLayoutProperties new;
		useHorizontalLinearLayout;
		renderer: GLMBrickRenderer new
]

{ #category : #'brick-testing' }
GLMBrick >> isFitsInParent [

	^ self owner
		"if our owner is a brick"
		ifNotNil: [ self owner globalBounds containsRect: self globalBounds ]
		"if our owner is a morph"
		ifNil: [ self owner ifNotNil: [ self owner bounds containsRect: self globalBounds ] ifNil: [ ^ true ] ]
]

{ #category : #'morph-common' }
GLMBrick >> isMorphBrick [

	^ false
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

	super layoutProperties: aLayoutProperties
]

{ #category : #'brick-drawing' }
GLMBrick >> onDraw: aCanvas [

	self renderer render: self on: aCanvas. 
]

{ #category : #'brick-properties-events' }
GLMBrick >> onThemerChanged [

	self changed
]

{ #category : #'brick-structure' }
GLMBrick >> owner [

	^ owner
]

{ #category : #'phlow-transmissions' }
GLMBrick >> ports [

	^ ports  ifNil: [ ports := Dictionary new ]
]

{ #category : #'private-structure' }
GLMBrick >> privateOwner: aBrick [

	owner := aBrick
]

{ #category : #'private-structure' }
GLMBrick >> privateSubbricks: aCollection [

	submorphs := aCollection
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

{ #category : #'private-extension' }
GLMBrick >> removeProperty: aSymbol [
	
	super removeProperty: aSymbol
]

{ #category : #'private-extension' }
GLMBrick >> setProperty: aSymbol toValue: anObject [
	
	super setProperty: aSymbol toValue: anObject
]

{ #category : #'brick-structure' }
GLMBrick >> subbricks [

	^ self submorphs
]

{ #category : #'morph-common' }
GLMBrick >> submorphAfter [

	^ self subbrickAfter
]

{ #category : #'morph-common' }
GLMBrick >> submorphBefore [

	^ self subbrickBefore
]

{ #category : #'morph-common' }
GLMBrick >> taskThumbnailOfSize: thumbExtent [
	"Answer a new task thumbnail for the receiver."

	|f t r|
	r := self globalBounds scaledAndCenteredIn: (0@0 extent: thumbExtent).
	f := Form extent: r extent depth: Display depth.
	t := MatrixTransform2x3 withScale: f extent / self extent.
	f getCanvas
		transformBy: t
		clippingTo: f boundingBox
		during: [:c | c translateBy: self globalBounds topLeft negated during: [:ct | self fullDrawOn: ct]]
		smoothing: 2.
	^ImageMorph new
		form: f
]

{ #category : #'morph-common' }
GLMBrick >> updateMorphBounds [

	self withAllSubbricks select: #isMorphBrick thenDo: #onLayouted
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
GLMBrick >> wrappedBounds [

	^ brickBounds ifNil: [ brickBounds := GLMBrickBounds new ]
]
