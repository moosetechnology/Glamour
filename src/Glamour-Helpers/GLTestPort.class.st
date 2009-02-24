Class {
	#name : #GLTestPort,
	#superclass : #GLPanePort,
	#instVars : [
		'seenTransmissions'
	],
	#category : #'Glamour-Tests'
}

{ #category : #accessing }
GLTestPort >> receive: aTransmission [
	
	self seenTransmissions addLast: aTransmission.
	^super receive: aTransmission
]

{ #category : #accessing }
GLTestPort >> seenTransmissions [
	
	^seenTransmissions ifNil: [seenTransmissions := OrderedCollection new]
]
