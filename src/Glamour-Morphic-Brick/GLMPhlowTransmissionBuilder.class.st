Class {
	#name : #GLMPhlowTransmissionBuilder,
	#superclass : #Object,
	#instVars : [
		'phlow',
		'transmission'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowTransmissionBuilder class >> phlow: anObject [

	^ self new phlow: anObject
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
	|from|
	from := anObject phlowValue: self phlow.
	self transmission addOrigin: (GLMPhlowOrigin target: from slot: aSlotSymbol).
	^ self
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

	self transmission destination: (GLMPhlowDestination target: anObject port: aPortObject).
	^ self
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing Slot in anObject"
	self transmission destination: (GLMPhlowDestination 
		target: anObject 
		port: (anObject class slotsDictionary at: aSlotSymbol)).
	^ self
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> toPort: anObject [

	^ self to: self phlow port: anObject
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> transformed: anObject [

	self transmission transformation: anObject
]

{ #category : #accessing }
GLMPhlowTransmissionBuilder >> transmission [

	^  transmission ifNil: [ transmission := GLMPhlowTransmission new phlow: self phlow ]
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> when: anObject [

	self transmission condition: anObject
]

{ #category : #scripting }
GLMPhlowTransmissionBuilder >> with: anObject [

	self transmission action: anObject
]
