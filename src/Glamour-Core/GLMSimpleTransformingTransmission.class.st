Class {
	#name : #GLMSimpleTransformingTransmission,
	#superclass : #GLMSimpleTransmission,
	#instVars : [
		'transformation'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMSimpleTransformingTransmission >> transformation [ 
	 
	^transformation ifNil: [#yourself]
]

{ #category : #accessing }
GLMSimpleTransformingTransmission >> transformation: anObject [ 
	 
	transformation _ anObject
]

{ #category : #transmitting }
GLMSimpleTransformingTransmission >> value [ 
	 
	^self transformation glamourValue: self origin value
]
