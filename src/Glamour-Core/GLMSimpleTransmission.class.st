"
A GLMSimpleTransmission connects one origin port with one destination port. Whenever the origin changes, the value is passed to the destination.
"
Class {
	#name : #GLMSimpleTransmission,
	#superclass : #GLMTransmission,
	#instVars : [
		'origin',
		'destination'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMSimpleTransmission >> destination [ 
	 
	^destination
]

{ #category : #accessing }
GLMSimpleTransmission >> destination: aPort [ 
	 
	destination := aPort
]

{ #category : #accessing }
GLMSimpleTransmission >> origin [ 
	 
	^origin
]

{ #category : #accessing }
GLMSimpleTransmission >> origin: aPort [ 
	 
	origin := aPort
]

{ #category : #testing }
GLMSimpleTransmission >> originatesAt: aPort [ 
	 
	^self origin = aPort
]

{ #category : #transmitting }
GLMSimpleTransmission >> transmitIn: aContext [
	 
	self destination receive: self in: aContext
]

{ #category : #transmitting }
GLMSimpleTransmission >> value [ 
	 
	^self origin value
]
