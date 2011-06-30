Class {
	#name : #GLMPortForwarder,
	#superclass : #Object,
	#instVars : [
		'forwards',
		'pane'
	],
	#category : #'Glamour-Core'
}

{ #category : #'instance creation' }
GLMPortForwarder class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
GLMPortForwarder class >> pane: aPane [
	^ self basicNew
		setPane: aPane;
		yourself
]

{ #category : #configuration }
GLMPortForwarder >> addForwardFrom:  aPortSymbol to: anotherPortSymbol andTransformWith:  ablock [
	|fromPort toPort|
	fromPort := pane port: aPortSymbol.
	toPort := pane port: anotherPortSymbol. 
	forwards
		detect: [:forward | forward fromPort = fromPort and: [forward toPort = toPort]]
		ifOne: [:forward | forwards remove: forward].
	forwards add: (GLMPortForward fromPort: fromPort toPort: toPort transformation: ablock)
]

{ #category : #actions }
GLMPortForwarder >> handle: anObject fromPort: aPortSymbol [
	|fromPort|
	fromPort := pane port: aPortSymbol.
	forwards
		select: [:forward | forward fromPort = fromPort]
		thenDo: [:forward | forward forward: anObject]
]

{ #category : #printing }
GLMPortForwarder >> printOn:  aStream [
	super printOn:  aStream.
	aStream nextPut: $(.
	forwards do: [:forward | aStream print: forward] separatedBy: [aStream nextPutAll:  ', '].
	aStream nextPut: $)
]

{ #category : #initialization }
GLMPortForwarder >> setPane: aPane [
	self initialize.
	pane := aPane.
	forwards  := Set new.

]

{ #category : #configuration }
GLMPortForwarder >> stopHandlingFromPort:  aPortSymbol [
	|fromPort| 
	fromPort := pane port: aPortSymbol.
	self removeAllSuchThat:  [:each | each fromPort = fromPort]
]
