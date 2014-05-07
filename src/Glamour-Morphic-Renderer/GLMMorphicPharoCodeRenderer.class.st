Class {
	#name : #GLMMorphicPharoCodeRenderer,
	#superclass : #GLMMorphicRubricTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> actOnEvaluateSelection: ann [ 

	textMorph textArea editor evaluateSelectionAndDo: ann action
]

{ #category : #rendering }
GLMMorphicPharoCodeRenderer >> modelFor: aPresentation [

	^ GLMRubricSmalltalkTextModel new
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		yourself
]

{ #category : #private }
GLMMorphicPharoCodeRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMSelectCurrentLine send: #selectLine to: self.
	aPresentation on: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self
	
]

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> selectLine [
	
	textMorph textArea editor lineSelectAndEmptyCheck: [^ nil]
]
