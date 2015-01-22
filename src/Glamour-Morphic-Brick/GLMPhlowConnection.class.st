"
A GLMPhlowConnection is asdasd

Instance Variables
	destination:		<Object>
	origin:		<Object>

destination
	- xxxxx

origin
	- xxxxx

"
Class {
	#name : #GLMPhlowConnection,
	#superclass : #Object,
	#instVars : [
		'origin',
		'destination',
		'transformation',
		'action'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'as yet unclassified' }
GLMPhlowConnection class >> origin: anOrigin destination: aDestination [

	^ self new origin: anOrigin; destination: aDestination; yourself
]

{ #category : #accessing }
GLMPhlowConnection >> action [
	^ action
]

{ #category : #accessing }
GLMPhlowConnection >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GLMPhlowConnection >> destination [
	^ destination
]

{ #category : #accessing }
GLMPhlowConnection >> destination: anObject [
	destination := anObject
]

{ #category : #accessing }
GLMPhlowConnection >> origin [
	^ origin
]

{ #category : #accessing }
GLMPhlowConnection >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
GLMPhlowConnection >> transformation [
	^ transformation
]

{ #category : #accessing }
GLMPhlowConnection >> transformation: anObject [
	transformation := anObject
]

{ #category : #transmission }
GLMPhlowConnection >> transmit [

	|value|
	value := self transformation phlowValue: (self origin slot read: self origin essence).
	self destination phlowValue: value.
	self action phlowValue: self destination essence value: value
	
]
