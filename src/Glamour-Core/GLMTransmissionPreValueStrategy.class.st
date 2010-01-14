Class {
	#name : #GLMTransmissionPreValueStrategy,
	#superclass : #Object,
	#instVars : [
		'transmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #'instance creation' }
GLMTransmissionPreValueStrategy class >> of: aTransmission [
	^ self new transmission: aTransmission; yourself
]

{ #category : #accessing }
GLMTransmissionPreValueStrategy >> addPresentation: aPresentation [
	"do nothing by default"
]

{ #category : #accessing }
GLMTransmissionPreValueStrategy >> addPresentations: aCollection [
	"do nothing by default"
]

{ #category : #accessing }
GLMTransmissionPreValueStrategy >> presentations [
	^ OrderedCollection new
]

{ #category : #accessing }
GLMTransmissionPreValueStrategy >> transmission [
	^ transmission
]

{ #category : #accessing }
GLMTransmissionPreValueStrategy >> transmission: anObject [
	transmission := anObject
]

{ #category : #transmitting }
GLMTransmissionPreValueStrategy >> transmitIn: aContext [
	"by default do nothing"
]
