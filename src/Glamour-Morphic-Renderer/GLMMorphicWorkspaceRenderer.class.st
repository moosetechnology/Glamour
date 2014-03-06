Class {
	#name : #GLMMorphicWorkspaceRenderer,
	#superclass : #GLMMorphicNewSmalltalkCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> actOnEvaluateSelection: ann [ 

	textMorph evaluateSelectionAndDo: ann action
]

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	self addVariableBindingsOn: textModel from: ann presentation.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> addVariableBindingsOn: aTextModel from: aPresentation [

	aPresentation variableBindings do: [ :each | aTextModel addVariableBinding: each ].
]

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
	aPresentation on: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self
]

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> textModelFor: aPresentation [
	| tm |
	tm := super textModelFor: aPresentation.
	self addVariableBindingsOn: tm from: aPresentation.
	tm bindingsStrategy: self workspaceBindingsStrategy.
	^ tm
]

{ #category : #'as yet unclassified' }
GLMMorphicWorkspaceRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		(currentBindings includesKey: aSymbol)
			ifFalse: [currentBindings at: aSymbol put: nil].
		currentBindings associationAt: aSymbol]
]
