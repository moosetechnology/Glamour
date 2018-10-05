Class {
	#name : #GLMMorphicTextRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicTextRenderer >> render: aPresentation [
	| textMorph toShow textModel | 
	toShow := aPresentation formatedDisplayValue. 
	textModel := GLMTextModel new
			text: toShow;
			glamourPresentation: aPresentation;
			highlightSmalltalk: aPresentation highlightSmalltalk;
			highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	textMorph := (PluggableShoutMorph
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
			yourself.
	"this is a horrible hack: 
	because we cannot get the update of when the text changes from the morph,
	we get the reference to the mutable text object :) :)"
	textModel text: textMorph textMorph asText. 
	self installActionsOnUI: textModel fromPresentation: aPresentation.
	aPresentation selectedTextBlock: [ textMorph textMorph editor selection ].
	aPresentation textBlock: [ textMorph textMorph editor text ].
	aPresentation when: GLMPresentationUpdated do: [:ann |
		textModel text: aPresentation formatedDisplayValue.
		textModel changed: #text ].
	aPresentation when: GLMContextChanged do: [ :ann | 
		ann property = #selectionInterval
			ifTrue: [ textMorph setSelection: ann value ] ].

	^ textMorph
]
