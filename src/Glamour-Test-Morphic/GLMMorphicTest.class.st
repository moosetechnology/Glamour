Class {
	#name : #GLMMorphicTest,
	#superclass : #TestCase,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphicTest >> repeatAssert: aBlock equals: aResult [

	self assert: (self wait: 1 until: aBlock evaluatesTo: aResult)
]

{ #category : #'as yet unclassified' }
GLMMorphicTest >> testChildrenBlock [

	| browser window check treeMorph mouseUp |
	browser := GLMFinder new.
	check := false.
	browser tree
		children: [:each | check := true. #()].
	window := browser openOn: ($a to: $d).
	treeMorph := 	window submorphs last submorphs first submorphs first submorphs first submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	mouseUp := MouseButtonEvent basicNew 
		setType: #mouseUp
		position: (treeMorph bounds origin + (1@1))
		which: 4
		buttons: 7
		hand: HandMorph new
		stamp: Time millisecondClockValue.
	treeMorph scroller submorphs first handleMouseUp: mouseUp.
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
