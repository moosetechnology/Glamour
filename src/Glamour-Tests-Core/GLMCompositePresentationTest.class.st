Class {
	#name : #GLMCompositePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMCompositePresentationTest >> testAdd [
	| composite |
	composite := GLMCompositePresentation new.
	composite add: GLMPresentation new.
	self assert: composite isEmpty not.
	self assert: composite presentations size equals: 1
]

{ #category : #tests }
GLMCompositePresentationTest >> testCreation [
	| composite |
	composite := GLMCompositePresentation new.
	self assert: composite isEmpty
]

{ #category : #tests }
GLMCompositePresentationTest >> testPane [
	| pane composite presentation |
	pane := GLMPane new.
	composite := GLMCompositePresentation new.
	presentation := GLMPresentation new.
	composite add: presentation.
	composite pane: pane.
	self assert: composite pane == pane.
	self assert: composite first pane == pane
]
