Class {
	#name : #REPConcernTest,
	#superclass : #TestCase,
	#category : #'Glamour-Reporter-Tests'
}

{ #category : #'as yet unclassified' }
REPConcernTest >> testDefaultStatus [
	self assert: REPComputedConcern new status notNil.
	self assert: REPComputedConcern new status color = TextColor black.
	self assert: REPComputedConcern new status label notNil
]

{ #category : #'as yet unclassified' }
REPConcernTest >> testDefaults [
	self assert: REPConcern new label = #REPConcern.
	self assert: REPConcern new explanation = #REPConcern.
]

{ #category : #'as yet unclassified' }
REPConcernTest >> testInfoConcernStatus [
	self assert: REPInfoConcern new statusValue isNil
]
