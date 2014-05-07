Class {
	#name : #GLMMorphicSmalltalkCodeRenderer,
	#superclass : #GLMMorphicTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> actOnCompileText: ann [ 
	
	"The current compiler wants to notify a text morph object in case of errors. 
	The compilation is delagated to the renderer, as the renderer has access
	to the text morph object."
	ann session 
		recompileMethodTo: ann presentation text 
		inContext: ann context 
		notifying: textMorph
]

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> actOnEvaluateSelection: ann [ 

	"We get here as a result of an announcement.
	If we do not defer the execution and an exception is triggered by the execution of the code
	then resuming the execution in the debugger will trigger an error when unwinding the stack."
	UIManager default defer: [ 
		textMorph evaluateSelectionAndDo: ann action ]
]

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	self addVariableBindingsOn: textModel from: ann presentation.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> addVariableBindingsOn: aTextModel from: aPresentation [

	aPresentation variableBindings do: [ :each | aTextModel addVariableBinding: each ].
]

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> debugSelection [

	textMorph debugIt
]

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> evaluateAndPrintSelection [

	textMorph printIt
]

{ #category : #callbacks }
GLMMorphicSmalltalkCodeRenderer >> profileSelection [

	textMorph tallyIt
]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> registerEventsForPresentation: aPresentation [ 

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
	aPresentation on: GLMEvaluateSelection send: #actOnEvaluateSelection: to: self.
	aPresentation on: GLMCompileText send: #actOnCompileText: to: self.
	aPresentation on: GLMDebugSelection send: #debugSelection to: self.
	aPresentation on: GLMProfileSelection send: #profileSelection to: self.
	aPresentation on: GLMPrintSelection send: #evaluateAndPrintSelection to: self.
	

]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> textModelFor: aPresentation [
	| tm |
	tm := GLMSmalltalkCodeModel new
		text: aPresentation formatedDisplayValue;
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	self addVariableBindingsOn: tm from: aPresentation.
	aPresentation isForScripting ifTrue: [ 
		tm bindingsStrategy: self workspaceBindingsStrategy ].
	^ tm
]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> textMorphForModel: aTextModel [
	| morph  |
	morph := GLMPluggableTextMorph new.
	morph styler workspace: aTextModel.
	morph
		on: aTextModel
			text: #text
			accept: #accept:notifying:
			readSelection: #selection
			menu: #menu:shifted:;
		changedAction: [:aText| 
			aText asString trimBoth ifNotEmpty:  [aTextModel text: aText] ];
		onKeyStrokeSend: #keystroke:from: to: aTextModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Smalltalk ui theme windowColor;
		font: StandardFonts codeFont;
		yourself.
	^ morph
]

{ #category : #private }
GLMMorphicSmalltalkCodeRenderer >> workspaceBindingsStrategy [

	^ [ :currentBindings :aSymbol |
		(currentBindings includesKey: aSymbol)
			ifFalse: [currentBindings at: aSymbol put: nil].
		currentBindings associationAt: aSymbol]
]
