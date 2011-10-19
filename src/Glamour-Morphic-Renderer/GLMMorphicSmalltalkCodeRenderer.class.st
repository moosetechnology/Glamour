Class {
	#name : #GLMMorphicSmalltalkCodeRenderer,
	#superclass : #GLMMorphicTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> render1: aPresentation [
	| toShow |
	toShow := aPresentation formatedDisplayValue.
	textModel := GLMSmalltalkCodeModel new 
					text: toShow;
					highlightSmalltalk: aPresentation highlightSmalltalk;
					highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	textMorph := TextMorph new
		wrapFlag: true;
		contents: toShow;
		autoFit: true;
		lock;
		hResizing: #spaceFill;
		vResizing: #spaceFill.
	textMorph unlock.
	^ textMorph
]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> textModelFor: aPresentation [
	| tm |
	tm := GLMSmalltalkCodeModel new
		text: aPresentation formatedDisplayValue;
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	aPresentation variableBindings do: [ :each | tm addVariableBinding: each ].
	^ tm
]

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> textMorphForModel: aTextModel [
	| morph  |
	morph := GLMPluggableTextMorph new.
	morph
		on: aTextModel
			text: #text
			accept: #accept:notifying:
			readSelection: #selection
			menu: #menu:shifted:;
		onKeyStrokeSend: #keystroke:from: to: aTextModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Color white;
		yourself.
	^ morph
]
