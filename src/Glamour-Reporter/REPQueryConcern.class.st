Class {
	#name : #REPQueryConcern,
	#superclass : #REPConcern,
	#instVars : [
		'computation',
		'result'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPQueryConcern >> browser [
	^ (MooseFinder startOn: self result) noTitle
]

{ #category : #hooks }
REPQueryConcern >> check [
	^ self subclassResponsibility
]

{ #category : #accessing }
REPQueryConcern >> computation [
	^ computation
]

{ #category : #accessing }
REPQueryConcern >> computation: anObject [
	computation := anObject
]

{ #category : #accessing }
REPQueryConcern >> result [
	^ result ifNil: [result := self check]
]

{ #category : #accessing }
REPQueryConcern >> result: anObject [
	result := anObject
]
