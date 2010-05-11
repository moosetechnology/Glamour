Class {
	#name : #REPConcernTest,
	#superclass : #TestCase,
	#category : #'Glamour-Reporter'
}

{ #category : #'as yet unclassified' }
REPConcernTest >> testDefaultStatus [
	self assert: REPConcern new status notNil.
	self assert: REPConcern new status color = Color black.
	self assert: REPConcern new status label inspect notNil
]

{ #category : #'as yet unclassified' }
REPConcernTest >> testDefaults [
	self assert: REPConcern new label = #REPConcern.
	self assert: REPConcern new explanation = #REPConcern.
]
