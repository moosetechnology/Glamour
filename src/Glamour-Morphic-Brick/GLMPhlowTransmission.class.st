"
asdads
as
d
asd
a
sd
"
Class {
	#name : #GLMPhlowTransmission,
	#superclass : #Object,
	#instVars : [
		'destination',
		'transformation',
		'action',
		'connections'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #accessing }
GLMPhlowTransmission >> action [
	
	^ action
]

{ #category : #accessing }
GLMPhlowTransmission >> action: anObject [

	action := anObject.
	self updateConnections
]

{ #category : #scripting }
GLMPhlowTransmission >> andPerform: anObject [

	self action: anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> connections [

	^ connections ifNil: [ connections := OrderedCollection new ]
]

{ #category : #accessing }
GLMPhlowTransmission >> destination [

	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destination: aPort [ 
	 
	destination := aPort.
	self updateConnections
]

{ #category : #scripting }
GLMPhlowTransmission >> from: anObject [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"anObject must have an instance variable named #selection to allow default transmissions"
	^ self from: anObject slot: #selection
]

{ #category : #'scripting-depreciated' }
GLMPhlowTransmission >> from: anObject port: aSlotSymbol [

	^ self from: anObject slot: aSlotSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> from: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	|connection|
	connection := GLMPhlowConnection
		origin: (GLMPhlowOrigin essence: anObject slot: aSlotSymbol)
		destination: self destination.
	anObject addConnection: connection.
	^ self connections add: connection
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"anObject must have an instance variable named #selection to allow default transmissions"
	^ self to: anObject slot: #selection
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject port: aPortObject [
	
	^ self destination: (GLMPhlowDestination essence: anObject port: aPortObject)
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing Slot in anObject"
	^ self destination: (GLMPhlowDestination essence: anObject slot: aSlotSymbol)
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation [

	^ transformation
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation: anObject [ 
	 
	transformation := anObject.
	self updateConnections
]

{ #category : #scripting }
GLMPhlowTransmission >> transformed: anObject [

	self transformation: anObject
]

{ #category : #private }
GLMPhlowTransmission >> updateConnections [

	self connections do: [ :each |
		each
			destination: self destination;
			transformation: self transformation;
			action: self action ]
]
