Class {
	#name : #GLMExpanderTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMExpanderTest >> testCreation [
	self assert: GLMExpander new panes isEmpty
]
