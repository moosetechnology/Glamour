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
		getSelectionSelector: #primarySelectionInterval;
		model: textModel;
		color: Smalltalk ui theme backgroundColor;
		yourself
]

{ #category : #private }
GLMMorphicRubricTextRenderer >> registerEventsForPresentation: aPresentation [

	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
]

{ #category : #rendering }
GLMMorphicRubricTextRenderer >> render: aPresentation [
	textModel := self modelFor: aPresentation.
	textModel primarySelectionInterval: aPresentation primarySelectionInterval.
	textMorph := self morph.
	aPresentation text: textMorph text.
	aPresentation withLineNumbers
		ifTrue: [ textMorph withLineNumbers ]
		ifFalse: [ textMorph withoutLineNumbers ].
	aPresentation withAnnotation
		ifTrue: [ textMorph withAnnotation ]
		ifFalse: [ textMorph withoutAnnotation ].
	aPresentation withColumns 
		ifTrue: [ textMorph withColumns ]
		ifFalse: [ textMorph withoutColumns ].
	textMorph wrapped: aPresentation wrapped.
	textMorph tabWidth: aPresentation tabWidth.
	aPresentation textSegments do: [:each | 
			textMorph addSegment: each ].
	(aPresentation textSegments anySatisfy: [ :ts | ts icon notNil ])
		ifTrue: [ textMorph withTextSegmentIcons ]
		ifFalse: [ textMorph withoutTextSegmentIcons ].
	textMorph textArea announcer
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
			
	textMorph textArea announcer
		on: RubTextAccepted
		do: [ :ann | aPresentation suspendAllWhile: [ aPresentation text: ann text ] ].
		
	self installActionsOnModel: textModel fromPresentation: aPresentation .
	self installKeystrokeActionsOnMorph: textMorph textArea fromPresentation: aPresentation.
	
	self registerEventsForPresentation: aPresentation.
	
	^ textMorph
]
