Class {
	#name : #GLMMorphicPharoCodeRenderer,
	#superclass : #GLMMorphicRubricTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicPharoCodeRenderer >> actOnEvaluateSelection: ann [ 

	"We get here as a result of an announcement.
	If we do not defer the execution and an exception is triggered by the execution of the code
	then resuming the execution in the debugger will trigger an error when unwinding the stack."
	UIManager default defer: [ 
		textMorph textArea editor evaluateSelectionAndDo: ann action ]
	
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
