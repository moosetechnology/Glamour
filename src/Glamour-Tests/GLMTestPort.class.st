Class {
	#name : #GLMTestPort,
	#superclass : #GLMPanePort,
	#instVars : [
		'seenTransmissions'
	],
	#category : #'Glamour-Tests'
}

{ #category : #accessing }
GLMTestPort >> receive: aTransmission [ 
	 
	self seenTransmissions addLast: aTransmission. 
	^super receive: aTransmission
]

{ #category : #accessing }
GLMTestPort >> seenTransmissions [ 
	 
	^seenTransmissions ifNil: [seenTransmissions := OrderedCollection new]
]
