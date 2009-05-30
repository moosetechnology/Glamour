Class {
	#name : #GLMTransmission,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Glamour-Core'
}

{ #category : #transmitting }
GLMTransmission >> context [

	^context
]

{ #category : #testing }
GLMTransmission >> originatesAt: aPort [ 
	 
	^false
]

{ #category : #transmitting }
GLMTransmission >> transmit [ 
	 
	self subclassResponsibility
]

{ #category : #transmitting }
GLMTransmission >> transmitIn: aTransmissionContext [
	 
	| newContext |
	newContext := OrderedCollection withAll: aTransmissionContext.
	newContext add: self.
	context := newContext.
	self transmit.
]

{ #category : #transmitting }
GLMTransmission >> value [ 
	 
	self subclassResponsibility
]
