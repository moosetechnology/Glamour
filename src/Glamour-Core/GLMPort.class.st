"
GLMPort represents the abstract port. Any port has a name. Subclasses can provide further semantics to a port.
"
Class {
	#name : #GLMPort,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLMPort >> hasPane [ 
	 
	^false
]

{ #category : #accessing }
GLMPort >> name [ 
	 
	^name
]

{ #category : #accessing }
GLMPort >> name: aSymbol [ 
	 
	name := aSymbol
]

{ #category : #printing }
GLMPort >> printOn: aStream [ 
	 
	aStream 
		nextPutAll: 'Port (name='; 
		nextPutAll: self name printString; 
		nextPutAll: ' value='; 
		nextPutAll: self value printString; 
		nextPut: $)
]

{ #category : #accessing }
GLMPort >> receive: aTransmission [ 
	self receive: aTransmission in: GLMTransmissionContext new
]

{ #category : #accessing }
GLMPort >> receive: aTransmission in: aContext [ 
	self subclassResponsibility
]

{ #category : #validation }
GLMPort >> validate: anObject [ 

	^true
]

{ #category : #accessing }
GLMPort >> value [ 
	 
	self subclassResponsibility
]

{ #category : #accessing }
GLMPort >> value: anObject [ 
	self value: anObject in: GLMTransmissionContext new
]

{ #category : #accessing }
GLMPort >> value: anObject in: aContext [
	self subclassResponsibility
]
