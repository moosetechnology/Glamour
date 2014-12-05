Class {
	#name : #GLMLongBandBrick,
	#superclass : #GLMBandBrick,
	#instVars : [
		'currentNode'
	],
	#category : #'Glamour-Morphic-Brick-UI'
}

{ #category : #example }
GLMLongBandBrick class >> example [
	|brick morph array N|
	N := 300000.
	
	morph := GLMFoundationBrick new.
	
	brick := GLMLongBandBrick new.
	morph brickRoot: brick.
	
	array := OrderedCollection new: N.
	1 to: N do: [ :index | array add: (GLMBrick new color: Color random muchLighter; height: 30; yourself) ].
	
	brick addAllBricks: array.
	morph extent: 300@600.
	morph openInWindow
	
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> addAllBricks: aCollection [
	|leafs|
	
	aCollection isEmpty ifTrue: [ ^ self ].
	
	leafs := self buildBrickTree: aCollection size.
	
	aCollection doWithIndex: [ :each :index |
		(leafs at: ((index asFloat / self maxNodeSize) ceiling asInteger)) addBrickBack: each ].
	
	^ leafs
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> buildBrickTree: anInteger [
	"builds a corresponding tree depending on the size
	returns array of brick leafs"
	|leafs amountOfLeafs depth|
	
	amountOfLeafs := self calculateAmountOfLeafs: anInteger.
	depth := self treeDepth: amountOfLeafs.
	
	leafs := OrderedCollection new: 2 ** depth.
	
	self privateAddNodeTo: self depth: 1 maxDepth: depth collect: leafs.
	
	leafs isEmpty ifTrue: [ leafs add: self ].
	
	^ leafs
	
	
	
	
	
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> calculateAmountOfLeafs: anInteger [
	"anInteger - amount of items in the list"
	^ (anInteger / self maxNodeSize) asFloat ceiling
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> calculateTreeDepth [

	
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> currentNode [

	^ currentNode
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> maxNodeSize [

	^ 1000
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> numberOfNodesOn: depth [
	"minimal depth is 0"
	^ 2 ** depth
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> privateAddBrick: aBrick [

	self currentNode addBrickBack: aBrick
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> privateAddNodeTo: aParent depth: currentDepth maxDepth: depth collect: aCollection [
	|left right|
	
	currentDepth > depth ifTrue: [ ^ self ].
	
	left := GLMBandCacheBrick new.
	right := GLMBandCacheBrick new.
	
	aParent addBrickBack: left.
	aParent addBrickBack: right.
	
	currentDepth = depth ifTrue: [ aCollection add: left; add:right ].
	
	self privateAddNodeTo: left depth: currentDepth + 1 maxDepth: depth collect: aCollection.
	self privateAddNodeTo: right depth: currentDepth + 1 maxDepth: depth collect: aCollection.
]

{ #category : #'as yet unclassified' }
GLMLongBandBrick >> treeDepth: anInteger [
	"given amount of leafs calculates the height of the tree"
	^ (anInteger asLargerPowerOfTwo log: 2) rounded asInteger
]
