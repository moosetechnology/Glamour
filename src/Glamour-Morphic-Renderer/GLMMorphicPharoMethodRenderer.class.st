Class {
	#name : #GLMMorphicPharoMethodRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicPharoMethodRenderer >> modelFor: aPresentation [

	^ GLMRubricSmalltalkTextModel new
		glamourPresentation: aPresentation;
		highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext;
		yourself
]
