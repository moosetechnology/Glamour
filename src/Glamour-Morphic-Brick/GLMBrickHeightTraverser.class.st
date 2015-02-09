Class {
	#name : #GLMBrickHeightTraverser,
	#superclass : #GLMBrickLayoutTraverser,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Glamour-Morphic-Brick-Utils'
}

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

	^ aBrick isHeightDependsOnChildren 
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnMyself: aBrick [
	
	^ aBrick isHeightDependsOnMyself
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnOpposite: aBrick [
	
	^ aBrick isHeightDependsOnWidth
]

{ #category : #private }
GLMBrickHeightTraverser >> isDependsOnParent: aBrick [
	
	^ aBrick isHeightDependsOnParent
]

{ #category : #private }
GLMBrickHeightTraverser >> isOppositeClean: aBrick [

	^ aBrick wrappedBounds isWidthClean
]

{ #category : #private }
GLMBrickHeightTraverser >> isOppositeDependsOn: aBrick [

	^ aBrick isWidthDependsOnHeight
	
]

{ #category : #private }
GLMBrickHeightTraverser >> markClean: aBrick [

	aBrick wrappedBounds markHeightClean
	
]

{ #category : #private }
GLMBrickHeightTraverser >> markDirty: aBrick [

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
