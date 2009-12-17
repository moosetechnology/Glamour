Class {
	#name : #GLMSimplePort,
	#superclass : #GLMPort,
	#instVars : [
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMSimplePort >> receive: aTransmission [ 
	
	self value: aTransmission value
]

{ #category : #accessing }
GLMSimplePort >> receive: aTransmission in: aContext [
	self value: aTransmission value
]

{ #category : #accessing }
GLMSimplePort >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMSimplePort >> value: anObject [
	value := anObject
]

{ #category : #accessing }
GLMSimplePort >> value: anObject in: aContext [
	aContext add: self.
	value := anObject
]
