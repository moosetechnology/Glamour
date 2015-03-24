Class {
	#name : #GLMBrickWidthTraverser,
	#superclass : #GLMBrickLayoutTraverser,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Utils'
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

	^ aBrick isWidthDependsOnChildren
	
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnMyself: aBrick [

	^ aBrick isWidthDependsOnMyself
	
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnOpposite: aBrick [

	^ aBrick isWidthDependsOnHeight	
]

{ #category : #private }
GLMBrickWidthTraverser >> isDependsOnParent: aBrick [

	^ aBrick isWidthDependsOnParent
	
]

{ #category : #private }
GLMBrickWidthTraverser >> isOppositeClean: aBrick [

	^ aBrick wrappedBounds isHeightClean
]

{ #category : #private }
GLMBrickWidthTraverser >> isOppositeDependsOn: aBrick [

	^ aBrick isHeightDependsOnWidth
	
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
