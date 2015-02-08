Class {
	#name : #GLMBrickLayouterTests,
	#superclass : #TestCase,
	#instVars : [
		'layouter'
	],
	#category : #'Glamour-Morphic-Brick-Tests'
}

{ #category : #asserting }
GLMBrickLayouterTests >> assertAllSubbricksAreClean: aBrick [

	aBrick withAllSubbricks do: [ :each | self assertBrickClean: each ]
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertAllSubbricksAreDirty: aBrick [

	aBrick withAllSubbricks do: [ :each | self assertBrickDirty: each ]
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertBrickClean: aBrick [

	self assertWidthClean: aBrick.
	self assertHeightClean: aBrick
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertBrickDirty: aBrick [

	self assertWidthDirty: aBrick.
	self assertHeightDirty: aBrick
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertHeightClean: aBrick [

	self assert: aBrick wrappedBounds heightState equals: #clean.
	self assert: aBrick wrappedBounds isHeightDirty not.
	self assert: aBrick wrappedBounds isHeightClean
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertHeightDirty: aBrick [

	self assert: aBrick wrappedBounds heightState equals: #dirty.
	self assert: aBrick wrappedBounds isHeightDirty.
	self assert: aBrick wrappedBounds isHeightClean not
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertWidthClean: aBrick [

	self assert: aBrick wrappedBounds widthState equals: #clean.
	self assert: aBrick wrappedBounds isWidthDirty not.
	self assert: aBrick wrappedBounds isWidthClean
]

{ #category : #asserting }
GLMBrickLayouterTests >> assertWidthDirty: aBrick [

	self assert: aBrick wrappedBounds widthState equals: #dirty.
	self assert: aBrick wrappedBounds isWidthDirty.
	self assert: aBrick wrappedBounds isWidthClean not
]

{ #category : #'instance-creation' }
GLMBrickLayouterTests >> newBrickFullHeightAndWidthDependsOnParent: anInteger [

	^ GLMBrick new
		vSpaceFill;
		hSpaceFill: anInteger;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickLayouterTests >> newBrickWithFullDependsOnChildren [

	^ GLMBrick new 
		hShrinkWrap;
		vShrinkWrap;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickLayouterTests >> newBrickWithFullFill [

	^ GLMBrick new 
		hSpaceFill;
		vSpaceFill;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickLayouterTests >> newBrickWithStaticExtent [

	^ GLMBrick new 
		height: self staticHeight;
		width: self staticWidth;
		yourself
]

{ #category : #running }
GLMBrickLayouterTests >> setUp [
	super setUp.
	
	layouter := GLMBrickLayouter new
]

{ #category : #defaults }
GLMBrickLayouterTests >> staticExtent [

	^ self staticWidth  @ self staticHeight
]

{ #category : #defaults }
GLMBrickLayouterTests >> staticHeight [

	^ 100
]

{ #category : #defaults }
GLMBrickLayouterTests >> staticWidth [

	^ 100
]

{ #category : #tests }
GLMBrickLayouterTests >> test100DependsOnChildrenBricksInsideOneStatic [
	|root current|
	
	root := self newBrickWithFullDependsOnChildren.
	current := root.
	1 to: 99 do: [ :index |
		current := current addBrickBack: self newBrickWithFullDependsOnChildren ].
	current := current addBrickBack: self newBrickWithStaticExtent.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: current extent
	
]

{ #category : #tests }
GLMBrickLayouterTests >> test100FillBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithFullFill ].
	
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #tests }
GLMBrickLayouterTests >> test100StaticBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithStaticExtent ].
	
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #tests }
GLMBrickLayouterTests >> testBrickDependsOnChildrenOneStatic [
	|root brick|
	
	root := self newBrickWithFullDependsOnChildren.
	brick := self newBrickWithStaticExtent.
	
	root addBrickBack: brick.
	
	self assert: root isWidthDependsOnChildren.
	self assert: root isHeightDependsOnChildren.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: brick extent
]

{ #category : #tests }
GLMBrickLayouterTests >> testChangeChildrenInParent [
	|parent brick|
	parent := self newBrickWithFullDependsOnChildren.
	brick := self newBrickWithStaticExtent.
	
	parent addBrickBack: brick.
	self assertAllSubbricksAreClean: parent.
	self assert: parent extent equals: brick extent.
	"height and width are changed, so parent should be re-layouted"
	brick height: self staticHeight * 2.
	brick width: self staticWidth * 2.
	
	self assertAllSubbricksAreClean: parent.
	self assert: brick extent equals: self staticExtent * 2.
	self assert: parent extent equals: brick extent
	

]

{ #category : #tests }
GLMBrickLayouterTests >> testChangeChildrenInParentAndSubchildren [
	|parent brick child|
	parent := self newBrickWithFullDependsOnChildren.
	brick := self newBrickWithStaticExtent.
	child := self newBrickFullHeightAndWidthDependsOnParent: 100.
	
	parent addBrickBack: brick.
	brick addBrickBack: child.
	self assertAllSubbricksAreClean: parent.
	self assert: parent extent equals: brick extent.
	self assert: child extent equals: brick extent.
	"height and width are changed, so parent should be re-layouted"
	brick height: self staticHeight * 2.
	brick width: self staticWidth * 2.
	
	self assertAllSubbricksAreClean: parent.
	self assert: brick extent equals: self staticExtent * 2.
	self assert: parent extent equals: brick extent.
	self assert: child extent equals: brick extent
	

]

{ #category : #tests }
GLMBrickLayouterTests >> testEmptyBrickDependsOnChildren [
	|brick|
	
	brick := self newBrickWithFullDependsOnChildren.
	
	self assert: brick isWidthDependsOnChildren.
	self assert: brick isHeightDependsOnChildren.
	
	self assertAllSubbricksAreDirty: brick.
	brick doLayout.
	self assertAllSubbricksAreClean: brick.
	
	self assert: brick extent equals: 0@0
]

{ #category : #tests }
GLMBrickLayouterTests >> testFillBrickInsideStatic [
	|root brick|
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithFullFill.
	brick isWidthDependsOnParent.
	brick isHeightDependsOnParent.
	root addBrickBack: brick.
	
	self assertAllSubbricksAreClean: root.
	self assert: brick extent equals: root extent
	
]

{ #category : #tests }
GLMBrickLayouterTests >> testFreshBrickIsDirty [

	self assertBrickDirty: GLMBrick new
]

{ #category : #tests }
GLMBrickLayouterTests >> testOneDependsOnParentOneDependsOnChildrenInsideStatic [
	|root brick1 brick2 brick3 staticWidth staticHeight|
	
	staticWidth := 20.
	staticHeight := 50.
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick2 := self newBrickWithFullDependsOnChildren.
	brick3 := GLMBrick new width: staticWidth; height: staticHeight; yourself.
	
	root addBrickBack: brick1.
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: self staticExtent).
	
	root addBrickBack: brick2.
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: self staticExtent).
	self assert: brick2 brickBounds equals: (self staticWidth @0 extent: 0@0).
	
	brick2 addBrickBack: brick3.
		
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth - staticWidth) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth - staticWidth)@0 extent: (staticWidth) @ staticHeight).
	self assert: brick3 brickBounds equals: (0@0 extent: (staticWidth) @ staticHeight).
	
]

{ #category : #tests }
GLMBrickLayouterTests >> testOneDependsOnParentOneStaticInsideStatic [
	|root brick1 brick2 staticWidth|
	
	staticWidth := 20.
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick2 := GLMBrick new width: staticWidth; vSpaceFill; yourself.
	
	root
		addBrickBack: brick1;
		addBrickBack: brick2.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth - staticWidth) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth - staticWidth)@0 extent: (staticWidth) @ self staticHeight).
	
]

{ #category : #tests }
GLMBrickLayouterTests >> testOneStaticBrick [
	|brick|
	
	brick := self newBrickWithStaticExtent.
	
	self assert: brick isWidthDependsOnMyself.
	self assert: brick isHeightDependsOnMyself.
	self assertBrickClean: brick.
	self assert: brick extent equals: self staticExtent
	
]

{ #category : #tests }
GLMBrickLayouterTests >> testShrinkWrapInStaticWithNeighbours [
	|root band child1 child2 neighbour childWidth width|
	width := 20.
	childWidth := self staticWidth - width.
	
	root := self newBrickWithStaticExtent useHorizontalLinearLayout.
	band := GLMBrick new useVerticalLinearLayout; hSpaceFill; vShrinkWrap.
	child1 := GLMBrick new height: self staticHeight; hSpaceFill.
	child2 := GLMBrick new height: self staticHeight; hSpaceFill.
	neighbour := GLMBrick new vSpaceFill; width: width.
	
	root addAllBricks: { band. neighbour }.
	band addAllBricks: { child1. child2 }.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root brickBounds equals: (0@0 extent: self staticExtent).
	self assert: neighbour brickBounds equals: (childWidth@0 extent: width@self staticHeight).
	self assert: child1 brickBounds equals: (0@0 extent: childWidth@self staticHeight).
	self assert: child2 brickBounds equals: (0@self staticHeight extent: childWidth@self staticHeight).
	self assert: band brickBounds equals: (0@0 extent: childWidth@(self staticHeight+self staticHeight)).
]

{ #category : #tests }
GLMBrickLayouterTests >> testTwoDependsOnParentInsideStatic [
	|root brick1 brick2|
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 50.
	brick2 := self newBrickFullHeightAndWidthDependsOnParent: 50.
	
	root
		addBrickBack: brick1;
		addBrickBack: brick2.

	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth / 2) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth / 2)@0 extent: (self staticWidth / 2) @ self staticHeight).
	
]
