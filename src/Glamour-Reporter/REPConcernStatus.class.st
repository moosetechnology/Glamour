Class {
	#name : #REPConcernStatus,
	#superclass : #Object,
	#instVars : [
		'value',
		'concern'
	],
	#category : #'Glamour-Reporter'
}

{ #category : #accessing }
REPConcernStatus >> color [ 
	self value = true ifTrue: [ ^ TextColor  new color: Color green darker ].
	self value = false ifTrue: [ ^ TextColor  new color: Color red darker ].
	^ TextColor black
]

{ #category : #accessing }
REPConcernStatus >> concern [
	^ concern
]

{ #category : #accessing }
REPConcernStatus >> concern: anObject [
	concern := anObject
]

{ #category : #accessing }
REPConcernStatus >> label [ 
	^ Text string: self concern label attribute: self color
]

{ #category : #accessing }
REPConcernStatus >> value [
	^ value
]

{ #category : #accessing }
REPConcernStatus >> value: anObject [
	value := anObject
]
