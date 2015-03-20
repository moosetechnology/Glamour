"
A GLMMorphBrick is used as container for morphs to embed them inside bricks

Instance Variables
	morph:		<Morph>

morph
	- xxxxx

"
Class {
	#name : #GLMMorphBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'morph',
		'resizing',
		'isLayouting',
		'vResizing',
		'hResizing'
	],
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #'instance creation' }
GLMMorphBrick class >> on: aMorph [

	^ self new on: aMorph
]

{ #category : #'brick-structure-adding/removing' }
GLMMorphBrick >> addBrickBack: aBrick [
	|link|
	link := aBrick asDoubleLink.
	aBrick brickDoubleLink: link.
	
	self hasSubbricks ifTrue: [
		self lastSubbrick brickDoubleLink nextLink: link.	
		link previousLink: self lastSubbrick brickDoubleLink.
	].
	
	self privateSubbricks: (self subbricks copyWith: aBrick).
	aBrick privateOwner: self.
]

{ #category : #'brick-geometry' }
GLMMorphBrick >> brickBounds: aRectangle [
	super brickBounds: aRectangle.
	
	self invalidateMorphBounds
]

{ #category : #'morph-drawing' }
GLMMorphBrick >> drawSubmorphsOn: aCanvas [
	
	self morph fullDrawOn: (aCanvas copy setOrigin: (aCanvas origin + self bounds origin - self morph bounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #'brick-layout-properties' }
GLMMorphBrick >> hShrinkWrap [
	
	hResizing := #shrinkWrap.
	self width: [ self morph width ]
	
	
]

{ #category : #initialization }
GLMMorphBrick >> initialize [
	super initialize.
	
	isLayouting := false
]

{ #category : #'brick-layout' }
GLMMorphBrick >> invalidateLayout [

	
]

{ #category : #'brick-layout' }
GLMMorphBrick >> invalidateMorphBounds [
	| origin corner newBounds |
	
	origin := self paddingLeft @ self paddingTop.
	corner := self paddingRight @ self paddingBottom.
	newBounds := self globalBounds.
	newBounds := ((newBounds origin + origin) corner: (newBounds corner - corner)).
	
	self morph bounds: newBounds
]

{ #category : #testing }
GLMMorphBrick >> isHShrinking [

	^ hResizing = #shrinkWrap
]

{ #category : #'morph-common' }
GLMMorphBrick >> isMorphBrick [

	^ true
]

{ #category : #testing }
GLMMorphBrick >> isShrinking [

	^ self isHShrinking | self isVShrinking
]

{ #category : #testing }
GLMMorphBrick >> isVShrinking [

	^ vResizing = #shrinkWrap
]

{ #category : #layout }
GLMMorphBrick >> layoutChanged [
	super layoutChanged.
	
	self morph ifNil: [ ^ self ].
	self isShrinking ifFalse: [ ^ self ].
	isLayouting ifTrue: [ ^ self ].

	isLayouting := true.
	self isHShrinking
		ifTrue: [ self width: [ self morph width ] ].
	self isVShrinking
		ifTrue: [ self height: [ self morph height ] ].
	isLayouting := false
]

{ #category : #accessing }
GLMMorphBrick >> morph [

	^ morph
]

{ #category : #'instance creation' }
GLMMorphBrick >> on: aMorph [
	
	aMorph layoutProperties ifNil: [ 
		aMorph layoutProperties: GLMBrickLayoutProperties new.
		aMorph layoutProperties hSpaceFill; vSpaceFill ].
	(aMorph layoutProperties isKindOf: GLMBrickLayoutProperties) ifTrue: [
		self layoutProperties: aMorph layoutProperties ].

	morph := aMorph.
	morph layoutProperties: (GLMBrickLayoutProperties new).
	morph layoutProperties hSpaceFill; vSpaceFill.
	
	self addBrickBack: morph.
	super brickBounds: (0@0 extent: (morph width@morph height)).
]

{ #category : #'brick-layout-events' }
GLMMorphBrick >> onLayouted [
	super onLayouted.
	
	self invalidateMorphBounds
]

{ #category : #'brick-structure-events' }
GLMMorphBrick >> onRemovedFrom: aBrick [
	
	"we should just override it and left empty,
	to prevent recursion calls of this method
	to be propagated to morph"
]

{ #category : #'brick-properties-events' }
GLMMorphBrick >> onThemerChanged [
	
]

{ #category : #'brick-properties' }
GLMMorphBrick >> themerChanged [

	self onThemerChanged.
	self morph brickThemerChanged
]

{ #category : #'brick-layout-properties' }
GLMMorphBrick >> vShrinkWrap [

	vResizing := #shrinkWrap.
	self height: [ self morph height ]
	
	
]
