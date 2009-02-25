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
GLMSimpleTransmission >> transmit [ 
	 
	self destination receive: self
]

{ #category : #transmitting }
GLMSimpleTransmission >> value [ 
	 
	^self origin value
]
