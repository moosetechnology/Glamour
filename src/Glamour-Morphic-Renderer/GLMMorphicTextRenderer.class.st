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
	textModel := (GLMTextModel new)
						text: toShow;
						glamourPresentation: aPresentation;
						highlightSmalltalk: aPresentation highlightSmalltalk;
						highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	textMorph := aPresentation highlightSmalltalk 
			ifTrue: [self smalltalkTextMorphForModel: textModel]
			ifFalse: [self textMorphForModel: textModel].
	
	"this is a horrible hack: 
	because we cannot get the update of when the text changes from the morph,
	we get the reference to the mutable text object :) :)"
	textModel text: textMorph textMorph asText.
	self installActionsOnUI: textModel fromPresentation: aPresentation.
	aPresentation selectedTextBlock: [ textMorph textMorph editor selection ].
	aPresentation textBlock: [ textMorph textMorph editor text ].
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ textMorph
]

{ #category : #rendering }
GLMMorphicTextRenderer >> smalltalkTextMorphForModel: textModel [
	| morph |
	morph := GLMPluggableShoutMorph new.
	morph
		styler: (SHTextStylerST80 new
			view: morph;
			yourself);
		on: textModel
			text: #text
			accept: #accept:notifying:
			readSelection: #selection
			menu: #menu:shifted:;
		onKeyStrokeSend: #keystroke:from: to: textModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Color white;
		yourself.
	^ morph
]

{ #category : #rendering }
GLMMorphicTextRenderer >> textMorphForModel: textModel [
	^ (PluggableTextMorph
		on: textModel
		text: #text
		accept: #accept:notifying:
		readSelection: #selection
		menu: #menu:shifted:)
		onKeyStrokeSend: #keystroke:from: to: textModel;
		layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		color: Color white;
		yourself
]
