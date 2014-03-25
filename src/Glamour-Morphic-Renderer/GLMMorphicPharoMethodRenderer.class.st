Class {
	#name : #GLMMorphicPharoMethodRenderer,
	#superclass : #GLMMorphicPharoCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicPharoMethodRenderer >> textModelFor: aPresentation [
	| tm |
	tm := super textModelFor: aPresentation.
	tm highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	^ tm
]
