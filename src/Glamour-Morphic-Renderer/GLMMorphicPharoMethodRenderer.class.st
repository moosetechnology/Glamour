Class {
	#name : #GLMMorphicPharoMethodRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicPharoMethodRenderer >> methodBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		 currentBindings associationAt: aSymbol ifAbsent: [nil] ]
]

{ #category : #rendering }
GLMMorphicPharoMethodRenderer >> modelFor: aPresentation [

	^ (super modelFor: aPresentation)
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext;
		bindingsStrategy: self methodBindingsStrategy;
		yourself
]

{ #category : #rendering }
GLMMorphicPharoMethodRenderer >> morph [
	|morph|
	 morph := RubScrolledTextMorph new
		beForSmalltalkCode;
		getSelectionSelector: #primarySelectionInterval;
		model: textModel;
		color: Smalltalk ui theme backgroundColor;
		textFont: StandardFonts codeFont;
		yourself.
	textModel addDependent: morph.
	^ morph
]
