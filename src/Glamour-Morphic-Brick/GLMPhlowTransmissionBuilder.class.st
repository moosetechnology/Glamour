Class {
	#name : #GLMPhlowTransmissionBuilder,
	#superclass : #Object,
	#instVars : [
		'action',
		'condition',
		'destination',
		'phlow',
		'transformation',
		'transmissions'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowTransmissionBuilder class >> phlow: anObject [

	^ self new phlow: anObject
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> action [
	
	^ action
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> action: anObject [

	action := anObject.
	self updateConnections
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> condition [
	^ condition
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> condition: anObject [

	condition := anObject.
	self updateConnections
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> destination [

	^ destination
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> destination: aPort [ 
	 
	destination := aPort.
	self updateConnections
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> from: anObject [

	^ self from: self phlow slot: anObject
]

{ #category : #'scripting-deprecated' }
GLMPhlowTransmissionBuilder >> from: anObject port: aSlotSymbol [

	^ self from: anObject slot: aSlotSymbol
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> from: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	|currentTransmission from|
	
	from := anObject phlowValue: self phlow.
	currentTransmission := GLMPhlowTransmission
		origin: (GLMPhlowOrigin target: from slot: aSlotSymbol)
		destination: self destination.
	from addTransmission: currentTransmission.
	^ self transmissions add: currentTransmission
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> phlow [
	^ phlow
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> phlow: anObject [
	phlow := anObject
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject [

	^ self to: self phlow slot: anObject
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject port: aPortObject [
	|to|
	to := anObject phlowValue: self phlow.
	^ self destination: (GLMPhlowDestination target: to port: aPortObject)
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing Slot in anObject"
	|to|
	to := anObject phlowValue: self phlow.
	^ self destination: (GLMPhlowDestination 
		target: anObject 
		port: (anObject class slotsDictionary at: aSlotSymbol))
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> toPort: anObject [

	^ self to: self phlow port: anObject
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> transformation [

	^ transformation
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> transformation: anObject [ 
	 
	transformation := anObject.
	self updateConnections
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> transformed: anObject [

	self transformation: anObject
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> transmissions [
	^  transmissions ifNil: [ transmissions := OrderedCollection new ]
]

{ #category : #private }
GLMPhlowTransmissionBuilder >> updateConnections [

	self transmissions do: [ :each |
		each
			destination: self destination;
			transformation: self transformation;
			action: self action;
			condition: self condition ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> when: anObject [

	self condition: anObject
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> with: anObject [

	self action: anObject
]
