Class {
	#name : #GLMMorphicTest,
	#superclass : #TestCase,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphicTest >> repeatAssert: aBlock equals: aResult [

	self assert: (self wait: 2 until: aBlock evaluatesTo: aResult)
]

{ #category : #'as yet unclassified' }
GLMMorphicTest >> testChildrenBlock [

	| browser window check |
	browser := GLMFinder new.
	check := false.
	browser tree
		children: [:each | check := true. #()].
	window := browser openOn: ($a to: $d).
	self repeatAssert: [check] equals: true.
	window delete
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMMorphicTest >> testSpawnFinder [

	| browser window check |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.
	window delete
]

{ #category : #'as yet unclassified' }
GLMMorphicTest >> testSpawnTableLayoutBrowser [

	| browser window check |
	browser := GLMTableLayoutBrowser new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [
		window submorphs last 
					submorphs last 
						submorphs last 
							submorphs last class] equals: LazyMorphTreeMorph.
	window delete
]

{ #category : #'as yet unclassified' }
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
