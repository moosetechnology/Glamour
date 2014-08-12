Class {
	#name : #GLMMorphicPharoPlaygroundRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	textModel appendVariableBinding: ann presentation variableBindings.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> modelFor: aPresentation [

	^ (super modelFor: aPresentation)
		bindingsStrategy: self workspaceBindingsStrategy;
		appendVariableBinding: aPresentation variableBindings;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> morph [
	^ RubScrolledTextMorph new
		model: textModel;
		beForSmalltalkScripting;
		textFont: StandardFonts codeFont;
		color: Smalltalk ui theme backgroundColor;
		notificationStrategy: GLMPopperNotificationStrategy new;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
]

{ #category : #'as yet unclassified' }
GLMMorphicPharoPlaygroundRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		(currentBindings includesKey: aSymbol)
			ifFalse: [currentBindings at: aSymbol put: nil].
		currentBindings associationAt: aSymbol]
]
