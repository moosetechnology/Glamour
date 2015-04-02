Class {
	#name : #GLMBrickWidthTraverser,
	#superclass : #GLMBrickLayoutTraverser,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Layouts-Utils'
}

{ #category : #cleanup }
GLMBrickWidthTraverser class >> cleanUp [

	uniqueInstance := nil
]

{ #category : #accessing }
GLMBrickWidthTraverser class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #private }
GLMBrickWidthTraverser >> customDependencies: aBrick [

	^ aBrick layout widthDependencies
]

{ #category : #private }
GLMBrickWidthTraverser >> hasMaxDimensionRestriction: aBrick [

	^ aBrick layout hasMaxWidth
]

{ #category : #private }
GLMBrickWidthTraverser >> hasMinDimensionRestriction: aBrick [

	^ aBrick layout hasMinWidth
]

{ #category : #private }
GLMBrickWidthTraverser >> isClean: aBrick [

	^ aBrick wrappedBounds isWidthClean
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnChildren: aBrick [

	"Returns true if my width depends only from my children, otherwise false.
	It means that layouter should first position my children and only then based on their
	sizes set my width"
	
	^ aBrick layout isHShrinkWrap
	
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnMyself: aBrick [
	"Returns true if my width depends only from myself, otherwise false.
	It means that layouter can immediately calculate and set it"
	
	^ aBrick layout isWidthCustom
	
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnOpposite: aBrick [
	"Returns true if my width depends from my height, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my width"
	
	^ aBrick layout isHOpposite
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnParent: aBrick [
	"Returns true if my width depends only on my parent, otherwise false.
	It means that layouter must first calculate width of my parent and only then my"
	
	^ aBrick layout isHSpaceFill
]

{ #category : #private }
GLMBrickWidthTraverser >> isOppositeClean: aBrick [

	^ aBrick wrappedBounds isHeightClean
]

{ #category : #private }
GLMBrickWidthTraverser >> isOppositeDependsOn: aBrick [

	"Returns true if my height depends on my width, otherwise false.
	It means that layouter must first calculate my width and as soon as it is done my height"
	
	^ aBrick layout isVOpposite
	
]

{ #category : #private }
GLMBrickWidthTraverser >> markClean: aBrick [

	aBrick wrappedBounds markWidthClean
	
]

{ #category : #private }
GLMBrickWidthTraverser >> markDirty: aBrick [

	self markLayoutDirty: aBrick owner.
	aBrick wrappedBounds markWidthDirty
	
]

{ #category : #private }
GLMBrickWidthTraverser >> markOppositeDirty: aBrick [

	aBrick wrappedBounds markHeightDirty
]

{ #category : #accessing }
GLMBrickWidthTraverser >> opposite [

	^ GLMBrickHeightTraverser uniqueInstance
]

{ #category : #private }
GLMBrickWidthTraverser >> updateDimension: aBrick [

	"my height is already calculated, maybe because it children triggered calculation"
	aBrick wrappedBounds isWidthClean ifTrue: [ ^ self ].
	(self dimensionPolicy: aBrick)  updateWidth: aBrick
]
