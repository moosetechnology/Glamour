Class {
	#name : #REPCustomQueryConcern,
	#superclass : #REPQueryConcern,
	#instVars : [
		'computation'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPCustomQueryConcern >> computation [
	^ computation
]

{ #category : #accessing }
REPCustomQueryConcern >> computation: anObject [
	computation := anObject
]

{ #category : #'as yet unclassified' }
REPCustomQueryConcern >> computeResult [ 
	^ self computation glamourValue: self model asGlamorousMultiValue 
]
