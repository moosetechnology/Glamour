Class {
	#name : #GLMMorphicPharoScriptRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicPharoScriptRenderer >> actOnVariableBindingsAccessRequest: ann [ 

	ann action ifNotNil: [ :aBlock |
		aBlock cull: textModel variableBindings ]
]

{ #category : #callbacks }
GLMMorphicPharoScriptRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	textModel appendVariableBinding: ann presentation variableBindings.
	textMorph shoutStyler style: textMorph text.
]

{ #category : #rendering }
GLMMorphicPharoScriptRenderer >> modelFor: aPresentation [

	^ (super modelFor: aPresentation)
		bindingsStrategy: self workspaceBindingsStrategy;
		appendVariableBinding: aPresentation variableBindings;
		yourself
]

{ #category : #rendering }
GLMMorphicPharoScriptRenderer >> morph [
	|morph|
	morph := RubScrolledTextMorph new
		model: textModel;
		beForSmalltalkScripting;
		getSelectionSelector: #primarySelectionInterval;
		textFont: StandardFonts codeFont;
		color: Smalltalk ui theme backgroundColor;
		notificationStrategy: GLMPopperNotificationStrategy new;
		yourself.
	textModel addDependent: morph.
	^ morph
]

{ #category : #private }
GLMMorphicPharoScriptRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	
	aPresentation when: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
	aPresentation when: GLMVariableBindingsAccessRequest send: #actOnVariableBindingsAccessRequest: to: self.
	
]

{ #category : #private }
GLMMorphicPharoScriptRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aString |
		(currentBindings includesKey: aString)
			ifFalse: [currentBindings add: (WorkspaceVariable key: aString asSymbol) ].
		currentBindings associationAt: aString]
]
