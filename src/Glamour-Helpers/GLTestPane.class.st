Class {
	#name : #GLTestPane,
	#superclass : #GLPane,
	#instVars : [
		'seenTransmissions'
	],
	#category : #'Glamour-Tests'
}

{ #category : #private }
GLTestPane class >> portClass [
	
	^GLTestPort
]
