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

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> test100DependsOnChildrenBricksInsideOneStatic [
	|root current|
	
	root := self newBrickWithFullDependsOnChildren.
	current := root.
	1 to: 99 do: [ :index |
		current := current addBrickBack: self newBrickWithFullDependsOnChildren ].
	current := current addBrickBack: self newBrickWithStaticExtent.
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: current extent
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> test100FillBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithFullFill ].
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> test100StaticBricksInsideEachOtherIndideStatic [
	|root current|
	
	root := self newBrickWithStaticExtent.
	current := root.
	1 to: 100 do: [ :index |
		current := current addBrickBack: self newBrickWithStaticExtent ].
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: current extent equals: root extent
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testBrickDependsOnChildrenOneStatic [
	|root brick|
	
	root := self newBrickWithFullDependsOnChildren.
	brick := self newBrickWithStaticExtent.
	
	root addBrickBack: brick.
	
	self assert: root isWidthDependsOnChildren.
	self assert: root isHeightDependsOnChildren.
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: brick extent
]

{ #category : #'tests-simple' }
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

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testFillBrickInsideStatic [
	|root brick|
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithFullFill.
	brick isWidthDependsOnParent.
	brick isHeightDependsOnParent.
	
	root addBrickBack: brick.
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: brick extent equals: root extent
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testFreshBrickIsDirty [

	self assertBrickDirty: self newBrickWithStaticExtent
]

{ #category : #'tests-horizontal-second-level-complexity' }
GLMBrickLayouterTests >> testOneDependsOnParentOneDependsOnChildrenInsideStatic [
	|root brick1 brick2 brick3 staticWidth staticHeight|
	
	staticWidth := 20.
	staticHeight := 50.
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick2 := self newBrickWithFullDependsOnChildren.
	brick3 := GLMBrick new width: staticWidth; height: staticHeight; yourself.
	
	root
		addBrickBack: brick1;
		addBrickBack: brick2.
	brick2 addBrickBack: brick3.
		
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth - staticWidth) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth - staticWidth)@0 extent: (staticWidth) @ staticHeight).
	self assert: brick3 brickBounds equals: (0@0 extent: (staticWidth) @ staticHeight).
	
]

{ #category : #'tests-horizontal-first-level-complexity' }
GLMBrickLayouterTests >> testOneDependsOnParentOneStaticInsideStatic [
	|root brick1 brick2 staticWidth|
	
	staticWidth := 20.
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 100.
	brick2 := GLMBrick new width: staticWidth; vSpaceFill; yourself.
	
	root
		addBrickBack: brick1;
		addBrickBack: brick2.
		
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth - staticWidth) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth - staticWidth)@0 extent: (staticWidth) @ self staticHeight).
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testOneStaticBrick [
	|brick|
	
	brick := self newBrickWithStaticExtent.
	brick doLayout.
	
	self assert: brick isWidthDependsOnMyself.
	self assert: brick isHeightDependsOnMyself.
	self assertBrickClean: brick.
	self assert: brick extent equals: self staticExtent
	
]

{ #category : #'tests-horizontal-first-level-complexity' }
GLMBrickLayouterTests >> testTwoDependsOnParentInsideStatic [
	|root brick1 brick2|
	
	root := self newBrickWithStaticExtent.
	brick1 := self newBrickFullHeightAndWidthDependsOnParent: 50.
	brick2 := self newBrickFullHeightAndWidthDependsOnParent: 50.
	
	root
		addBrickBack: brick1;
		addBrickBack: brick2.
		
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
	self assert: root extent equals: self staticExtent.
	self assert: brick1 brickBounds equals: (0@0 extent: (self staticWidth / 2) @ self staticHeight).
	self assert: brick2 brickBounds equals: ((self staticWidth / 2)@0 extent: (self staticWidth / 2) @ self staticHeight).
	
]
