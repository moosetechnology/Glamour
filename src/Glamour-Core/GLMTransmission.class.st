Class {
	#name : #GLMTransmission,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Glamour-Core'
}

{ #category : #testing }
GLMTransmission >> originatesAt: aPort [ 
	 
	^false
]

{ #category : #transmitting }
GLMTransmission >> transmit [ 
	 
	self subclassResponsibility
]

{ #category : #transmitting }
GLMTransmission >> value [ 
	 
	self subclassResponsibility
]
