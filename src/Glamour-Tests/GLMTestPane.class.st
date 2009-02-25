Class {
	#name : #GLMTestPane,
	#superclass : #GLMPane,
	#instVars : [
		'seenTransmissions'
	],
	#category : #'Glamour-Tests'
}

{ #category : #private }
GLMTestPane class >> portClass [ 
	 
	^GLMTestPort
]
