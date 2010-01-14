Class {
	#name : #GLMTransmissionStrategy,
	#superclass : #Object,
	#instVars : [
		'transmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #'instance creation' }
GLMTransmissionStrategy class >> of: aTransmission [
	^ self new transmission: aTransmission; yourself
]

{ #category : #accessing }
GLMTransmissionStrategy >> addPresentation: aPresentation [
	"do nothing by default"
]

{ #category : #accessing }
GLMTransmissionStrategy >> addPresentations: aCollection [
	"do nothing by default"
]

{ #category : #accessing }
GLMTransmissionStrategy >> presentations [
	^ OrderedCollection new
]

{ #category : #accessing }
GLMTransmissionStrategy >> transmission [
	^ transmission
]

{ #category : #accessing }
GLMTransmissionStrategy >> transmission: anObject [
	transmission := anObject
]

{ #category : #transmitting }
GLMTransmissionStrategy >> transmitIn: aContext [
	"by default do nothing"
]
