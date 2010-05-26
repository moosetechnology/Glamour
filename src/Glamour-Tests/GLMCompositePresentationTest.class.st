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

{ #category : #'as yet unclassified' }
GLMCompositePresentationTest >> testEquality [
	| composite1 composite2 presentations |
	composite1 := GLMCompositePresentation new.
	composite2 := GLMCompositePresentation new.
	presentations := OrderedCollection with: GLMPresentation new with: GLMPresentation new.
	composite1 presentations: presentations.
	composite2 presentations: presentations.
	self assert: composite1 = composite2
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMCompositePresentationTest >> testSimpleEquality [
	| composite1 composite2 |
	composite1 := GLMCompositePresentation new.
	composite2 := GLMCompositePresentation new.
	self assert: composite1 = composite2
]
