Class {
	#name : #GLMPhlowTransmission,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'transformation',
		'action',
		'condition'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowTransmission class >> origin: anOrigin destination: aDestination [

	^ self new origin: anOrigin; destination: aDestination; yourself
]

{ #category : #accessing }
GLMPhlowTransmission >> action [
	^ action
]

{ #category : #accessing }
GLMPhlowTransmission >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> condition [
	^ condition
]

{ #category : #accessing }
GLMPhlowTransmission >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> destination [
	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destination: anObject [
	destination := anObject
]

{ #category : #private }
GLMPhlowTransmission >> meetsCondition [
	
	^ ((self condition phlowValue: self origin phlowObject) = false) not
]

{ #category : #accessing }
GLMPhlowTransmission >> origin [
	^ origin
]

{ #category : #accessing }
GLMPhlowTransmission >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation [
	^ transformation
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation: anObject [
	transformation := anObject
]

{ #category : #transmission }
GLMPhlowTransmission >> transmit [
	|value|
	"we transmit only if meets condition"
	self meetsCondition ifFalse: [ ^ self ].
	"obtaining slot value and transforming it"
	value := self transformation phlowValue: (self origin slot read: self origin phlowObject).
	"transmiting transformed value to destination port"
	self destination phlowValue: value.
	"performing specified action"
	self action phlowValue: self destination phlowObject value: value
	
]
