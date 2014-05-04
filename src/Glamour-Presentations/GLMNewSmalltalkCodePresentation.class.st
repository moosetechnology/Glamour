Class {
	#name : #GLMNewSmalltalkCodePresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMNewSmalltalkCodePresentation >> evaluateSelection [

	self evaluateSelectionAndDo: [ :result | result ]
]

{ #category : #'as yet unclassified' }
GLMNewSmalltalkCodePresentation >> evaluateSelectionAndDo: aBlock [

	self announce: (GLMEvaluateSelection new action: aBlock)
]
