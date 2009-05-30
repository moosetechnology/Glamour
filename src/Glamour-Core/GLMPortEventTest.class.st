Class {
	#name : #GLMPortEventTest,
	#superclass : #TestCase,
	#category : #'Glamour-Core-Tests'
}

{ #category : #testing }
GLMPortEventTest >> testCreation [
	| anEvent |
	anEvent := GLMPortEvent 
		on: 1
		previouslyValued: 2.
	self assert: anEvent port = 1.
	self assert: anEvent oldValue = 2.
	self assert: anEvent transmissionContext isEmpty.
]

{ #category : #testing }
GLMPortEventTest >> testCreationWithTransmissionContext [
	| anEvent |
	anEvent := GLMPortEvent 
		on: 1
		previouslyValued: 2
		in: 3.
	self assert: anEvent port = 1.
	self assert: anEvent oldValue = 2.
	self assert: anEvent transmissionContext = 3.
]

{ #category : #testing }
GLMPortEventTest >> testPortName [
	| anEvent |
	anEvent := GLMPortEvent 
		on: ((GLMPort new) name: '1'; yourself)
		previouslyValued: 2.
	self assert: anEvent portName = '1'.

]
