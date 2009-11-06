Class {
	#name : #GLMTreePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMTreePresentationTest >> testValidate [
	 
	| pane port presentation| 
	pane := GLMPane named: 'test'. 
	presentation := GLMTreePresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	self assert: (presentation validate: 1 on: (pane port: #selection)).
	self assert: (presentation validate: 2 on: (pane port: #selection)).
	self deny: (presentation validate: 5 on: (pane port: #selection))
]
