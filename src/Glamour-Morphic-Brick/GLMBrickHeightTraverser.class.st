Class {
	#name : #GLMBrickHeightTraverser,
	#superclass : #GLMBrickLayoutTraverser,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Layouts-Utils'
}

{ #category : #cleanup }
GLMBrickHeightTraverser class >> cleanUp [

	uniqueInstance := nil
]

{ #category : #accessing }
GLMBrickHeightTraverser class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #private }
GLMBrickHeightTraverser >> customDependencies: aBrick [

	^ aBrick layout heightDependencies
]

{ #category : #private }
GLMBrickHeightTraverser >> hasMaxDimensionRestriction: aBrick [

	^ aBrick layout hasMaxHeight
]

{ #category : #private }
GLMBrickHeightTraverser >> hasMinDimensionRestriction: aBrick [

	^ aBrick layout hasMinHeight
]

{ #category : #private }
GLMBrickHeightTraverser >> isClean: aBrick [

	^ aBrick wrappedBounds isHeightClean
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnChildren: aBrick [
	"Returns true if my height depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my height"
	
	^ aBrick layout isVShrinkWrap
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnMyself: aBrick [
	"Returns true if my height depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ aBrick layout isHeightCustom
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnOpposite: aBrick [
	"Returns true if my height depends from my width, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my height"
	
	^ aBrick layout isVOpposite
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnParent: aBrick [

	"Returns true if my height depends only from my parent, otherwise false.
	It means that layouter must first calculate height of my parent and only then my"
	
	^ aBrick layout isVSpaceFill
]

{ #category : #private }
GLMBrickHeightTraverser >> isOppositeClean: aBrick [

	^ aBrick wrappedBounds isWidthClean
]

{ #category : #private }
GLMBrickHeightTraverser >> isOppositeDependsOn: aBrick [
	"Returns true if my width depends from my height, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my width"
	
	^ aBrick layout isHOpposite
	
]

{ #category : #private }
GLMBrickHeightTraverser >> markClean: aBrick [

	aBrick wrappedBounds markHeightClean
	
]

{ #category : #private }
GLMBrickHeightTraverser >> markDirty: aBrick [

	self markLayoutDirty: aBrick owner.
	aBrick wrappedBounds markHeightDirty
]

{ #category : #private }
GLMBrickHeightTraverser >> markOppositeDirty: aBrick [

	aBrick wrappedBounds markWidthDirty
]

{ #category : #accessing }
GLMBrickHeightTraverser >> opposite [

	^ GLMBrickWidthTraverser uniqueInstance
]

{ #category : #private }
GLMBrickHeightTraverser >> updateDimension: aBrick [
	"my height is already calculated, maybe because my children triggered calculation"
	aBrick wrappedBounds isHeightClean ifTrue: [ ^ self ].
	
	(self dimensionPolicy: aBrick) updateHeight: aBrick
]
