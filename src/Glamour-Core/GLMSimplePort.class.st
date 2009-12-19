Class {
	#name : #GLMSimplePort,
	#superclass : #GLMPort,
	#instVars : [
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMSimplePort >> receive: aTransmission in: aContext [
	self value: aTransmission value in: aContext
]

{ #category : #accessing }
GLMSimplePort >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMSimplePort >> value: anObject in: aContext [
	aContext addPort: self.
	value := anObject
]
