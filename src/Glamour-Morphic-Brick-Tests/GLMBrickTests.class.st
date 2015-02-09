Class {
	#name : #GLMBrickTests,
	#superclass : #TestCase,
	#instVars : [
		'layouter'
	],
	#category : #'Glamour-Morphic-Brick-Tests'
}

{ #category : #asserting }
GLMBrickTests >> assertAllSubbricksAreClean: aBrick [

	aBrick withAllSubbricks do: [ :each | self assertBrickClean: each ]
]

{ #category : #asserting }
GLMBrickTests >> assertAllSubbricksAreDirty: aBrick [

	aBrick withAllSubbricks do: [ :each | self assertBrickDirty: each ]
]

{ #category : #asserting }
GLMBrickTests >> assertBrickClean: aBrick [

	self assertWidthClean: aBrick.
	self assertHeightClean: aBrick
]

{ #category : #asserting }
GLMBrickTests >> assertBrickDirty: aBrick [

	self assertWidthDirty: aBrick.
	self assertHeightDirty: aBrick
]

{ #category : #asserting }
GLMBrickTests >> assertHeightClean: aBrick [

	self assert: aBrick wrappedBounds heightState equals: #clean.
	self assert: aBrick wrappedBounds isHeightDirty not.
	self assert: aBrick wrappedBounds isHeightClean
]

{ #category : #asserting }
GLMBrickTests >> assertHeightDirty: aBrick [

	self assert: aBrick wrappedBounds heightState equals: #dirty.
	self assert: aBrick wrappedBounds isHeightDirty.
	self assert: aBrick wrappedBounds isHeightClean not
]

{ #category : #asserting }
GLMBrickTests >> assertWidthClean: aBrick [

	self assert: aBrick wrappedBounds widthState equals: #clean.
	self assert: aBrick wrappedBounds isWidthDirty not.
	self assert: aBrick wrappedBounds isWidthClean
]

{ #category : #asserting }
GLMBrickTests >> assertWidthDirty: aBrick [

	self assert: aBrick wrappedBounds widthState equals: #dirty.
	self assert: aBrick wrappedBounds isWidthDirty.
	self assert: aBrick wrappedBounds isWidthClean not
]

{ #category : #'instance-creation' }
GLMBrickTests >> newBrickFullHeightAndWidthDependsOnParent: anInteger [

	^ GLMBrick new
		vSpaceFill;
		hSpaceFill: anInteger;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickTests >> newBrickWithFullDependsOnChildren [

	^ GLMBrick new 
		hShrinkWrap;
		vShrinkWrap;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickTests >> newBrickWithFullFill [

	^ GLMBrick new 
		hSpaceFill;
		vSpaceFill;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickTests >> newBrickWithSmallStaticExtent [

	^ GLMBrick new 
		height: self staticSmallHeight;
		width: self staticSmallWidth;
		yourself
]

{ #category : #'instance-creation' }
GLMBrickTests >> newBrickWithStaticExtent [

	^ GLMBrick new 
		height: self staticHeight;
		width: self staticWidth;
		yourself
]

{ #category : #running }
GLMBrickTests >> setUp [
	super setUp.
	
	layouter := GLMBrickLayouter new
]

{ #category : #defaults }
GLMBrickTests >> staticExtent [

	^ self staticWidth  @ self staticHeight
]

{ #category : #defaults }
GLMBrickTests >> staticHeight [

	^ 100
]

{ #category : #defaults }
GLMBrickTests >> staticSmallExtent [

	^ self staticSmallWidth  @ self staticSmallHeight
]

{ #category : #defaults }
GLMBrickTests >> staticSmallHeight [

	^ 50
]

{ #category : #defaults }
GLMBrickTests >> staticSmallWidth [

	^ 50
]

{ #category : #defaults }
GLMBrickTests >> staticWidth [

	^ 100
]

{ #category : #'tests-layouter' }
GLMBrickTests >> test100DependsOnChildrenBricksInsideOneStatic [
	|root current|
	
	root := self newBrickWithFullDependsOnChildren.
	current := root.
	1 to: 99 do: [ :index |
		current := current addBrickBack: self newBrickWithFullDependsOnChildren ].
	current := current addBrickBack: self newBrickWithStaticExtent.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: current extent
	
]

{ #category : #'tests-layouter' }
GLMBrickTests >> test100FillBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithFullFill ].
	
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #'tests-layouter' }
GLMBrickTests >> test100StaticBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithStaticExtent ].
	
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testBottomMarginMyselfDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginBottom: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (0@0 extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testBottomMarginParentDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick marginBottom: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: (self staticExtent - (0@margin)).
	self assert: brick brickBounds equals: (0@0 corner: self staticExtent - (0@margin))
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testBrickDependsOnChildrenOneStatic [
	|root brick|
	
	root := self newBrickWithFullDependsOnChildren.
	brick := self newBrickWithStaticExtent.
	
	root addBrickBack: brick.
	
	self assert: root isWidthDependsOnChildren.
	self assert: root isHeightDependsOnChildren.
	
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: brick extent
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testChangeChildrenInParent [
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

{ #category : #'tests-layouter' }
GLMBrickTests >> testChangeChildrenInParentAndSubchildren [
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

{ #category : #'tests-layouter' }
GLMBrickTests >> testEmptyBrickDependsOnChildren [
	|brick|
	
	brick := self newBrickWithFullDependsOnChildren.
	
	self assert: brick isWidthDependsOnChildren.
	self assert: brick isHeightDependsOnChildren.
	
	self assertAllSubbricksAreDirty: brick.
	brick doLayout.
	self assertAllSubbricksAreClean: brick.
	
	self assert: brick extent equals: 0@0
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testFillBrickInsideStatic [
	|root brick|
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithFullFill.
	brick isWidthDependsOnParent.
	brick isHeightDependsOnParent.
	root addBrickBack: brick.
	
	self assertAllSubbricksAreClean: root.
	self assert: brick extent equals: root extent
	
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testFreshBrickIsDirty [

	self assertBrickDirty: GLMBrick new
]

{ #category : #'tests-floating' }
GLMBrickTests >> testLeftFloatingMySelfDependency [
	|root floating brick|
	floating := #left.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick layout floating: floating.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (0@0 extent: self staticSmallExtent)
]

{ #category : #'tests-floating' }
GLMBrickTests >> testLeftFloatingMySelfDependencyWithMargin [
	|root floating margin brick|
	margin := 10.
	floating := #left.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginLeft: margin.
	brick layout floating: floating.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (margin@0 extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testLeftMarginChangeMyselfDependency [
	|root margin newMargin brick|
	margin := 10.
	newMargin := 20.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginLeft: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (margin@0 extent: self staticSmallExtent).
	
	brick marginLeft: newMargin.
	brick doLayoutForce.
	
	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (newMargin@0 extent: self staticSmallExtent).
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testLeftMarginMyselfDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginLeft: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (margin@0 extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testLeftMarginParentDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick marginLeft: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: (self staticExtent - (margin@0)).
	self assert: brick brickBounds equals: (margin@0 corner: self staticExtent)
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testOneDependsOnParentOneDependsOnChildrenInsideStatic [
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

{ #category : #'tests-layouter' }
GLMBrickTests >> testOneDependsOnParentOneStaticInsideStatic [
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

{ #category : #'tests-layouter' }
GLMBrickTests >> testOneStaticBrick [
	|brick|
	
	brick := self newBrickWithStaticExtent.
	
	self assert: brick isWidthDependsOnMyself.
	self assert: brick isHeightDependsOnMyself.
	self assertBrickClean: brick.
	self assert: brick extent equals: self staticExtent
	
]

{ #category : #'tests-floating' }
GLMBrickTests >> testRightFloatingMySelfDependency [
	|root floating brick|
	floating := #right.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick layout floating: floating.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: ((self staticWidth - self staticSmallWidth)@0 extent: self staticSmallExtent)
]

{ #category : #'tests-floating' }
GLMBrickTests >> testRightFloatingMySelfDependencyWithMargin [
	|root margin floating brick|
	margin := 10.
	floating := #right.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick layout floating: floating.
	brick marginRight: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: ((self staticWidth - margin - self staticSmallWidth)@0 extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testRightMarginMyselfDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginRight: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (0@0 extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testRightMarginParentDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick marginRight: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: (self staticExtent - (margin@0)).
	self assert: brick brickBounds equals: (0@0 corner: self staticExtent - (margin@0))
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testShrinkWrapInStaticWithNeighbours [
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

{ #category : #'tests-geometry' }
GLMBrickTests >> testTopMarginMyselfDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithSmallStaticExtent.
	brick marginTop: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: self staticSmallExtent.
	self assert: brick brickBounds equals: (0@margin extent: self staticSmallExtent)
]

{ #category : #'tests-geometry' }
GLMBrickTests >> testTopMarginParentDependency [
	|root margin brick|
	margin := 10.
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick marginTop: margin.
	root addBrickBack: brick.

	self assertAllSubbricksAreClean: root.
	self assert: root extent equals: self staticExtent.
	self assert: brick extent equals: (self staticExtent - (0@margin)).
	self assert: brick brickBounds equals: (0@margin corner: self staticExtent)
]

{ #category : #'tests-layouter' }
GLMBrickTests >> testTwoDependsOnParentInsideStatic [
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