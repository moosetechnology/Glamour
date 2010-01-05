"
A PortReference is used in Transmissions to bahavior that is specific to a Transmission instance.
"
Class {
	#name : #GLMPortReference,
	#superclass : #Object,
	#instVars : [
		'port'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPortReference >> port [ 
	 
	^port
]

{ #category : #accessing }
GLMPortReference >> port: aPort [
	port := aPort
]
