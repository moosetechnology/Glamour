Class {
	#name : #GLMMorphicPharoCodeRenderer,
	#superclass : #GLMMorphicTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicPharoCodeRenderer >> textModelFor: aPresentation [
	| tm |
	tm := GLMSmalltalkCodeModel new
		text: aPresentation formatedDisplayValue;
		glamourPresentation: aPresentation;
		highlightSmalltalk: true.
	^ tm
]

{ #category : #rendering }
GLMMorphicPharoCodeRenderer >> textMorphForModel: aTextModel [
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
