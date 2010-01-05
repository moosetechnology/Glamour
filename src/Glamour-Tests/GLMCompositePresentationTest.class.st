Class {
	#name : #GLMCompositePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMCompositePresentationTest >> testAdd [
	| composite |
	composite := GLMCompositePresentation new.
	composite add: GLMPresentation new.
	self assert: composite isEmpty not.
	self assert: composite presentations size = 1
]

{ #category : #'as yet unclassified' }
GLMCompositePresentationTest >> testCreation [
	| composite |
	composite := GLMCompositePresentation new.
	self assert: composite isEmpty
]
