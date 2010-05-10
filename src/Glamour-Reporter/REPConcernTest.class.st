Class {
	#name : #REPConcernTest,
	#superclass : #TestCase,
	#category : #'Glamour-Reporter'
}

{ #category : #'as yet unclassified' }
REPConcernTest >> testDefaults [
	self assert: REPConcern new label = #REPConcern.
	self assert: REPConcern new explanation = #REPConcern.
]
