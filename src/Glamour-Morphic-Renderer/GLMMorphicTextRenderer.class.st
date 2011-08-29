Class {
	#name : #GLMMorphicTextRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'textModel',
		'textMorph'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicTextRenderer >> actOnContextChanged: ann [ 
	ann property = #selectionInterval
		ifTrue: [ textMorph setSelection: ann value ]
]

{ #category : #rendering }
GLMMorphicTextRenderer >> actOnPresentationUpdated: ann [ 
	textModel text: ann presentation formatedDisplayValue.
	textModel changed: #text
]

{ #category : #rendering }
GLMMorphicTextRenderer >> render: aPresentation [
	| toShow |
	toShow := aPresentation formatedDisplayValue.
	textModel := GLMTextModel new
						text: toShow;
						glamourPresentation: aPresentation;
						highlightSmalltalk: aPresentation highlightSmalltalk;
						highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	aPresentation variableBindings do: [:each | textModel addVariableBinding: each].
	textMorph := aPresentation highlightSmalltalk 
			ifTrue: [self smalltalkTextMorphForModel: textModel]
			ifFalse: [self textMorphForModel: textModel].
	
	"this is a horrible hack: 
	because we cannot get the update of when the text changes from the morph,
	we get the reference to the mutable text object :) :)"
	textModel text: textMorph textMorph asText.
	self installActionsOnUI: textModel fromPresentation: aPresentation.
	
	textMorph announcer 
		on: GLMSelectedTextChanged 
		do: [:ann | 
			aPresentation announcer suspendAllWhile: [
				aPresentation selectionInterval: ann interval.
				aPresentation selectedText: ann selectedText ]].

	aPresentation textBlock: [ textMorph textMorph editor text ].
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ textMorph
]

{ #category : #rendering }
GLMMorphicTextRenderer >> smalltalkTextMorphForModel: aTextModel [
	| morph styler |
	morph := GLMPluggableTextMorph new.
	styler := SHTextStylerST80 new
			view: morph;
			workspace: textModel;
			yourself.
	morph
		styler: styler;
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

{ #category : #rendering }
GLMMorphicTextRenderer >> textMorphForModel:  aTextModel [
	^ (GLMPluggableTextMorph
		on: aTextModel
		text: #text
		accept: #accept:notifying:
		readSelection: #selection
		menu: #menu:shifted:)
		onKeyStrokeSend: #keystroke:from: to: aTextModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Color white;
		yourself
]
