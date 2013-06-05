Class {
	#name : #GLMMorphicRubricTextRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'textMorph',
		'textModel'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicRubricTextRenderer >> actOnContextChanged: ann [
	ann property = #selectionInterval
		ifTrue: [
			ann value notNil 
				ifTrue: [textMorph setSelection: ann value ]
				ifFalse: [textMorph setSelection: (1 to: 0)] ]
]

{ #category : #private }
GLMMorphicRubricTextRenderer >> actOnPresentationUpdated: ann [ 
	textMorph setText: ann presentation formatedDisplayValue
]

{ #category : #rendering }
GLMMorphicRubricTextRenderer >> modelFor: aPresentation [
	^ GLMRubricTextModel new
		glamourPresentation: aPresentation;
		yourself
]

{ #category : #rendering }
GLMMorphicRubricTextRenderer >> morph [
	^ RubScrolledTextMorph new
		model: textModel;
		yourself
]

{ #category : #rendering }
GLMMorphicRubricTextRenderer >> render: aPresentation [
	textModel := self modelFor: aPresentation.
	textMorph := self morph.
	aPresentation text: textMorph text.
	textMorph announcer
		on: RubTextChanged
		do: [ :ann | 
			aPresentation announcer
				suspendAllWhile: [ aPresentation text: textMorph text ] ].
	textMorph textArea announcer
		on: RubSelectionChanged
		do: [ :ann | 
			aPresentation announcer
				suspendAllWhile: [ 
					aPresentation selectionInterval: textMorph selectionInterval.
					aPresentation selectedText: textMorph textArea selection ] ].
	self installActionsOnModel: textModel fromPresentation: aPresentation .
	self installKeystrokeActionsOnMorph: textMorph textArea fromPresentation: aPresentation.

	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ textMorph
]
