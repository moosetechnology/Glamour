Class {
	#name : #GLMMorphicRubricHighlightedTextRenderer,
	#superclass : #GLMMorphicRubricTextRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicRubricHighlightedTextRenderer >> morph [
	| morph |
	
	morph := super morph.
	morph editingMode: textModel glamourPresentation editingMode.
	^ morph
		
]
