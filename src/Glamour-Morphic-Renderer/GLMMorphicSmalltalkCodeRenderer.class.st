Class {
	#name : #GLMMorphicSmalltalkCodeRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicSmalltalkCodeRenderer >> render: aPresentation [
	| toShow textModel textMorph |
	toShow := aPresentation formatedDisplayValue.
	textModel := GLMTextModel new text: toShow.
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
