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
