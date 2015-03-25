Class {
	#name : #GLMMorphicPharoPlaygroundRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicPharoPlaygroundRenderer >> actOnVariableBindingsAccessRequest: ann [ 

	ann action ifNotNil: [ :aBlock |
		aBlock cull: textModel variableBindings ]
]

{ #category : #callbacks }
GLMMorphicPharoPlaygroundRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	textModel appendVariableBinding: ann presentation variableBindings.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #rendering }
GLMMorphicPharoPlaygroundRenderer >> modelFor: aPresentation [

	^ (super modelFor: aPresentation)
		bindingsStrategy: self workspaceBindingsStrategy;
		appendVariableBinding: aPresentation variableBindings;
		yourself
]

{ #category : #rendering }
GLMMorphicPharoPlaygroundRenderer >> morph [
	^ RubScrolledTextMorph new
		model: textModel;
		beForSmalltalkScripting;
		textFont: StandardFonts codeFont;
		color: Smalltalk ui theme backgroundColor;
		notificationStrategy: GLMPopperNotificationStrategy new;
		yourself
]

{ #category : #private }
GLMMorphicPharoPlaygroundRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
	aPresentation on: GLMVariableBindingsAccessRequest send: #actOnVariableBindingsAccessRequest: to: self.
	
]

{ #category : #private }
GLMMorphicPharoPlaygroundRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aString |
		(currentBindings includesKey: aString)
			ifFalse: [currentBindings add: (WorkspaceVariable key: aString asSymbol) ].
		currentBindings associationAt: aString]
]
