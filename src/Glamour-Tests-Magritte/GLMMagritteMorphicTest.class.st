Class {
	#name : #GLMMagritteMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Magritte'
}

{ #category : #tests }
GLMMagritteMorphicTest >> testOnAnswer [ 
	| magritte onAnswerValue onAnswerPresentation onAnswerEntity |
	magritte := GLMMagrittePresentation new.
	magritte description: [:x | x description].
	magritte entity: 42.
	magritte onAnswer: [:value :presentation :entity | 
		onAnswerValue := value.
		onAnswerPresentation := presentation.
		onAnswerEntity := entity ].
	magritte reactOnAnswerFor: 100.
	self assert: onAnswerValue = 100.
	self assert: onAnswerPresentation = magritte.
	self assert: onAnswerEntity = 42
]
