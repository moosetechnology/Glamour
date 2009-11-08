Class {
	#name : #GLMListPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMListPresentationTest >> testChildren [
	| tree |
	tree := GLMTreePresentation new.
	tree transformation: [:aNumber | (1 to: aNumber ) collect: #printString ].
	tree children: [:each | self assert: (each isKindOf: String)  ].
	tree entity: 42.
]

{ #category : #'as yet unclassified' }
GLMListPresentationTest >> testToSend [
	| list |
	list := GLMListPresentation new.
	list selectionTransformation: [ :x | x + 1 ].
	list entity: #(1 #to: 41 ).
	list selection: 41.
	self assert: list selection = 42
]

{ #category : #tests }
GLMListPresentationTest >> testValidateOn [
	 
	| pane port presentation| 
	pane := GLMPane named: 'test'. 
	presentation := GLMListPresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	self assert: (presentation validate: 1 on: (pane port: #selection)).
	self assert: (presentation validate: 2 on: (pane port: #selection)).
	self deny: (presentation validate: 5 on: (pane port: #selection))
]

{ #category : #tests }
GLMListPresentationTest >> testValidatePorts [
	 
	| pane port presentation| 
	pane := GLMPane named: 'test'.
	presentation := GLMListPresentation new.
	pane addPresentation: presentation.
	presentation entity: (OrderedCollection with: 1 with: 2).
	presentation selection: 2.
	self assert: presentation selection = 2.
	presentation selection: 3."this should be invalid"
	self assert: presentation selection = 2
]
