Class {
	#name : #GLSimplePort,
	#superclass : #GLPort,
	#instVars : [
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLSimplePort >> receive: aTransmission [
	
	self value: aTransmission value
]

{ #category : #accessing }
GLSimplePort >> value [
	
	^value
]

{ #category : #accessing }
GLSimplePort >> value: anObject [
	
	value := anObject
]
