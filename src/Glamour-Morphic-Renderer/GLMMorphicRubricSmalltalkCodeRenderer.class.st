Class {
	#name : #GLMMorphicRubricSmalltalkCodeRenderer,
	#superclass : #GLMMorphicRubricTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicRubricSmalltalkCodeRenderer >> morph [
	^ RubScrolledTextMorph new
		model: textModel;
		beForSmalltalkCode;
		yourself
]
