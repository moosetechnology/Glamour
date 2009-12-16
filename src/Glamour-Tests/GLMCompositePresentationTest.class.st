Class {
	#name : #GLMCompositePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMCompositePresentationTest >> testCreation [
	| composite |
	composite := GLMCompositePresentation new.
	self assert: composite presentations isEmpty
]
