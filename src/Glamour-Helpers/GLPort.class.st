Class {
	#name : #GLPort,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLPort >> hasPane [
	
	^false
]

{ #category : #accessing }
GLPort >> name [
	
	^name
]

{ #category : #accessing }
GLPort >> name: aSymbol [
	
	name := aSymbol
]

{ #category : #printing }
GLPort >> printOn: aStream [
	
	aStream
		nextPutAll: 'Port (name->';
		nextPutAll: self name printString;
		nextPutAll: ' value->';
		nextPutAll: self value printString;
		nextPut: $)
]

{ #category : #accessing }
GLPort >> receive: aTransmission [
	
	self subclassResponsibility
]

{ #category : #accessing }
GLPort >> value [
	
	self subclassResponsibility
]

{ #category : #accessing }
GLPort >> value: anObject [
	
	self subclassResponsibility
]
