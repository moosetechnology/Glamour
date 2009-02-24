Class {
	#name : #GLSimpleTransmission,
	#superclass : #GLTransmission,
	#instVars : [
		'origin',
		'destination'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLSimpleTransmission >> destination [
	
	^destination
]

{ #category : #accessing }
GLSimpleTransmission >> destination: aPort [
	
	destination := aPort
]

{ #category : #accessing }
GLSimpleTransmission >> origin [
	
	^origin
]

{ #category : #accessing }
GLSimpleTransmission >> origin: aPort [
	
	origin := aPort
]

{ #category : #testing }
GLSimpleTransmission >> originatesAt: aPort [
	
	^self origin = aPort
]

{ #category : #transmitting }
GLSimpleTransmission >> transmit [
	
	self destination receive: self
]

{ #category : #transmitting }
GLSimpleTransmission >> value [
	
	^self origin value
]
