Class {
	#name : #GLMMockSimpleTransmission,
	#superclass : #GLMTransmission,
	#instVars : [
		'wasTransmited'
	],
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMMockSimpleTransmission class >> new [

	^super new initialize
]

{ #category : #testing }
GLMMockSimpleTransmission >> initialize [
	super initialize.
	wasTransmited := false
]

{ #category : #testing }
GLMMockSimpleTransmission >> transmit [

	wasTransmited := true.
	super transmit.
]

{ #category : #testing }
GLMMockSimpleTransmission >> transmitIn: aContext [

	wasTransmited := true.
	super transmitIn: aContext
]

{ #category : #testing }
GLMMockSimpleTransmission >> wasTransmited [
	^wasTransmited
]
