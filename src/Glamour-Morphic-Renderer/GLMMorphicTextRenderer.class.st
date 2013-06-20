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
		ifTrue: [ 
			ann value notNil 
				ifTrue: [textMorph setSelection: ann value ]
				ifFalse: [textMorph setSelection: (1 to: 0)] ]
]

{ #category : #rendering }
GLMMorphicTextRenderer >> actOnPresentationUpdated: ann [ 
	textModel text: ann presentation formatedDisplayValue.
	textModel changed: #text
]

{ #category : #rendering }
GLMMorphicTextRenderer >> render: aPresentation [
	textModel := self textModelFor: aPresentation.
	textMorph := self textMorphForModel: textModel.	"this is a horrible hack: 
	because we cannot get the update of when the text changes from the morph,
	we get the reference to the mutable text object :) :)"
	textModel text: textMorph text.
	textMorph setSelection: textModel selection. "Without setting the selection again 
	the smalltalkcode presentation shows no selection. Seems to be cause by the font: 
	message send when creating a GLMPluggableTextMorph"
	self installActionsOnModel: textModel fromPresentation: aPresentation .
	self installKeystrokeActionsOnMorph: textMorph textMorph fromPresentation: aPresentation.
	textMorph announcer
		on: GLMSelectedTextChanged
		do: [ :ann | 
			aPresentation announcer
				suspendAllWhile: [ 
					aPresentation selectionInterval: ann interval.
					aPresentation selectedText: ann selectedText ] ].
	textMorph announcer
		on: GLMTextChanged
		do: [ :ann | aPresentation suspendAllWhile: [ aPresentation text: ann text ] ].
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ textMorph
]

{ #category : #rendering }
GLMMorphicTextRenderer >> textModelFor: aPresentation [
	^ GLMTextModel new
		text: aPresentation formatedDisplayValue;
		glamourPresentation: aPresentation
]

{ #category : #rendering }
GLMMorphicTextRenderer >> textMorphForModel:  aTextModel [
	^ (GLMPluggableTextMorph
		on: aTextModel
		text: #text
		accept: #accept:notifying:
		readSelection: #selection
		menu: #menu:shifted:)
		changedAction: [:aText|
			aText asString trimBoth ifNotEmpty:  [aTextModel text: aText] ];
		onKeyStrokeSend: #keystroke:from: to: aTextModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Color white;
		detachAllKeymapCategories;
		yourself
]
