Class {
	#name : #GLMMorphicTest,
	#superclass : #TestCase,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #private }
GLMMorphicTest >> repeatAssert: aBlock equals: aResult [

	self assert: (self wait: 0.5 until: aBlock evaluatesTo: aResult)
]

{ #category : #private }
GLMMorphicTest >> send: treeMorph mouseUpOnItem: treeNodeMorph [
	| mouseUp |
	mouseUp := MouseButtonEvent basicNew 
		setType: #mouseUp
		position: (treeNodeMorph bounds origin + (1@1))
		which: 4
		buttons: 7
		hand: (HandMorph new mouseFocus: treeNodeMorph; yourself)
		stamp: nil.
	treeMorph mouseUp: mouseUp onItem: treeNodeMorph.
]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlock [

	| browser window check treeMorph mouseUp treeNodeMorph |
	browser := GLMFinder new.
	check := false.
	browser tree
		children: [:each | check := true. #()].
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self repeatAssert: [check] equals: true
]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlockTakesEntity [

	| browser receivedEntity window |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser tree
		children: [:each :entity | receivedEntity := entity. #()].
	window := browser openOn: ($a to: $d).
	self repeatAssert: [receivedEntity] equals: ($a to: $d).
	window delete
]

{ #category : #testing }
GLMMorphicTest >> testColumnBlockTakesEntity [

	| browser receivedEntity window |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser table
		column: 'Even' evaluated: [:each :entity | receivedEntity := entity. 'x'].
	window := browser openOn: (1 to: 5).
	self repeatAssert: [receivedEntity] equals: (1 to: 5).
	window delete
]

{ #category : #testing }
GLMMorphicTest >> testSpawnFinder [

	| browser window check |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.
	window delete
]

{ #category : #testing }
GLMMorphicTest >> testSpawnTableLayoutBrowser [

	| browser window check |
	browser := GLMTabulator new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [
		window submorphs last 
					submorphs last 
						submorphs last 
							submorphs last class] equals: LazyMorphTreeMorph.
	window delete
]

{ #category : #private }
GLMMorphicTest >> wait: maxWaitSeconds until: validateBlock evaluatesTo: expectedResult [
	"Evaluate validateBlock until it returns expectedResult or 
maxWaitSeconds have passed,
	 pausing between evaluations.  Return the last result of validateBlock 
value"

	| startTime result |
	startTime := Time secondClock.
	[result := validateBlock value = expectedResult] whileFalse:
			[Time secondClock - startTime > maxWaitSeconds ifTrue: [^result].
			(Delay forMilliseconds: 50) wait].
	^ result

]
