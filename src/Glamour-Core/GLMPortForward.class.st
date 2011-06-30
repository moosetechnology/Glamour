Class {
	#name : #GLMPortForward,
	#superclass : #Object,
	#instVars : [
		'fromPort',
		'transformation',
		'toPort'
	],
	#category : #'Glamour-Core'
}

{ #category : #'instance creation' }
GLMPortForward class >> fromPort: aPort toPort: anotherPort transformation: aBlock [
	^ self new
		setFromPort:  aPort toPort: anotherPort transformation: aBlock;
		yourself
]

{ #category : #'instance creation' }
GLMPortForward class >> standardForwardForPane: aPane [
	^ self fromPort: (aPane port: #selection) toPort:  (aPane port: #selection) transformation: #yourself
]

{ #category : #actions }
GLMPortForward >> forward: anObject [
	toPort value: (transformation glamourValue: anObject)
]

{ #category : #accessing }
GLMPortForward >> fromPort [
	^ fromPort
]

{ #category : #printing }
GLMPortForward >> printOn:  aStream [
	super printOn:  aStream. 
	aStream
		nextPut: $(;
		nextPutAll: fromPort name;
		nextPutAll:  ' -> ' ;
		nextPutAll:  toPort name;
		nextPut: $) 
]

{ #category : #'initialize-release' }
GLMPortForward >> setFromPort: aPort toPort: anotherPort transformation: aBlock [
	self initialize. 
	fromPort  := aPort.
	toPort := anotherPort.
	transformation := aBlock.
]

{ #category : #accessing }
GLMPortForward >> toPort [
	^ toPort
]

{ #category : #accessing }
GLMPortForward >> transformation [
	^ transformation
]
