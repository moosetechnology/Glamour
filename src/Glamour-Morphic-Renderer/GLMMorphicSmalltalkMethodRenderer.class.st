Class {
	#name : #GLMMorphicSmalltalkMethodRenderer,
	#superclass : #GLMMorphicNewSmalltalkCodeRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicSmalltalkMethodRenderer >> textModelFor: aPresentation [
	| tm |
	tm := super textModelFor: aPresentation.
	tm highlightSmalltalk: true;
		highlightSmalltalkContext: aPresentation highlightSmalltalkContext.
	^ tm
]
