Class {
	#name : #GLMMorphicSmalltalkCodeRenderer,
	#superclass : #GLMMorphicTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicSmalltalkCodeRenderer >> actOnVariableBindingsUpdated: ann [ 

	textModel variableBindings: nil.
	self addVariableBindingsOn: textModel from: ann presentation.
	textModel changed: #text. self flag: 'update just the style here'
]

{ #category : #'as yet unclassified' }
GLMMorphicSmalltalkCodeRenderer >> addVariableBindingsOn: aTextModel from: aPresentation [

	aPresentation variableBindings do: [ :each | aTextModel addVariableBinding: each ].
]

{ #category : #'as yet unclassified' }
GLMMorphicSmalltalkCodeRenderer >> registerEventsForPresentation: aPresentation [

	super registerEventsForPresentation: aPresentation.
	aPresentation on: GLMVariableBindingsChanged send: #actOnVariableBindingsUpdated: to: self.
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
		color: Color white;
		font: StandardFonts codeFont;
		yourself.
	^ morph
]
