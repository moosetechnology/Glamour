Class {
	#name : #REPCompositeConcern,
	#superclass : #REPConcern,
	#instVars : [
		'children'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPCompositeConcern >> addChild: aConcern [
	^ self children add: aConcern
]

{ #category : #accessing }
REPCompositeConcern >> children [
	^ children
]

{ #category : #accessing }
REPCompositeConcern >> children: anObject [
	children := anObject
]

{ #category : #'initialize-release' }
REPCompositeConcern >> initialize [
	super initialize.
	children := OrderedCollection new
]
