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
GLMBrickLayouterTests >> staticHeight [

	^ 100
]

{ #category : #defaults }
GLMBrickLayouterTests >> staticWidth [

	^ 100
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testFreshBrickIsDirty [

	self assertBrickDirty: self newBrickWithStaticExtent
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testLayout100FillBricksInsideEachOtherIndideStatic [
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
GLMBrickLayouterTests >> testLayoutFillBrickInsideStatic [
	|root brick|
	
	root := self newBrickWithStaticExtent.
	brick := self newBrickWithFullFill.
	root addBrickBack: brick.
	
	self assertAllSubbricksAreDirty: root.
	root doLayout.
	self assertAllSubbricksAreClean: root.
	
]

{ #category : #'tests-simple' }
GLMBrickLayouterTests >> testLayoutOneStaticBrick [
	|brick|
	
	brick := self newBrickWithStaticExtent.
	brick doLayout.
	self assertBrickClean: brick.
	self assert: brick extent equals: self staticWidth @ self staticHeight
	
]
