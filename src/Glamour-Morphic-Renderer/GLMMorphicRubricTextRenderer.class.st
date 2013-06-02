Class {
	#name : #GLMMorphicRubricTextRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'textMorph',
		'textModel'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicRubricTextRenderer >> render: aPresentation [
	textModel := GLMRubricTextModel new glamourPresentation: aPresentation; yourself.
	textMorph := RubScrolledTextMorph new
"		withLineNumbers;"
"		withGhostText: 'Ghost';"
		model: textModel;
		yourself.
"	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.		"
	^ textMorph
]
