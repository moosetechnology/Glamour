"
This class models the context in which a set of transmissions take place. In essence, it records all ports that were reached after an outside event.
 
Instance Variables
	ports:		Collection of Ports
"
Class {
	#name : #GLMTransmissionContext,
	#superclass : #Object,
	#instVars : [
		'ports'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMTransmissionContext >> addPort: aPort [
	self ports add: aPort
]

{ #category : #testing }
GLMTransmissionContext >> includesPort: aPort [
	^ self ports includes: aPort
]

{ #category : #accessing }
GLMTransmissionContext >> ports [
	^ ports ifNil: [ports := OrderedCollection new]
]

{ #category : #accessing }
GLMTransmissionContext >> ports: anObject [
	ports := anObject
]

{ #category : #copying }
GLMTransmissionContext >> postCopy [
	ports := ports copy
]
