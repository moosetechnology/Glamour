Class {
	#name : #GLMMorphicPharoMethodRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicPharoMethodRenderer >> methodBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		 currentBindings associationAt: aSymbol ifAbsent: [nil] ]
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoMethodRenderer >> modelFor: aPresentation [

	^ (super modelFor: aPresentation)
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext;
		bindingsStrategy: self methodBindingsStrategy;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoMethodRenderer >> morph [
	
	^ RubScrolledTextMorph new
		beForSmalltalkCode;
		model: textModel;
		yourself
]
