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
GLMMorphicTest >> testSimple [

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
