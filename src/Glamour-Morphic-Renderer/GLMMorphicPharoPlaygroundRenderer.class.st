Class {
	#name : #GLMMorphicPharoPlaygroundRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> actOnEvaluateSelection: ann [ 

	textMorph evaluateSelectionAndDo: ann action
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	self addVariableBindingsOn: textModel from: ann presentation.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> modelFor: aPresentation [

	^ GLMRubricSmalltalkTextModel new
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		bindingsStrategy: self workspaceBindingsStrategy;
		appendVariableBinding: aPresentation variableBindings;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> morph [
	
	^ RubScrolledTextMorph new
		getSelectionSelector: #primarySelectionInterval;
		model: textModel;
		beForSmalltalkScripting;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
	aPresentation on: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		(currentBindings includesKey: aSymbol)
			ifFalse: [currentBindings at: aSymbol put: nil].
		currentBindings associationAt: aSymbol]
]
