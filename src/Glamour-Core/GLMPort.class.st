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
	 
	name _ aSymbol
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
	 
	self subclassResponsibility
]

{ #category : #accessing }
GLMPort >> value [ 
	 
	self subclassResponsibility
]

{ #category : #accessing }
GLMPort >> value: anObject [ 
	 
	self subclassResponsibility
]
