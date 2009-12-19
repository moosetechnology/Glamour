Class {
	#name : #GLMTransmissionContextTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #testing }
GLMTransmissionContextTest >> testCopy [
	| context copy |
	context := GLMTransmissionContext new.
	context addPort: GLMSimplePort new.
	copy := context copy.
	self assert: copy ~~ context.
	self assert: copy ports = context ports.
	self assert: copy ports ~~ context ports.

]

{ #category : #testing }
GLMTransmissionContextTest >> testInclues [
	| context port |
	port := GLMSimplePort new.
	context := GLMTransmissionContext new.
	context addPort: port.
	self assert: (context includesPort: port)
]
