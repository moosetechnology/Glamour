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
		'origins',
		'destination',
		'transformation',
		'action'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #accessing }
GLMPhlowTransmission >> action [
	
	^ action
]

{ #category : #accessing }
GLMPhlowTransmission >> action: anObject [

	action := anObject
]

{ #category : #scripting }
GLMPhlowTransmission >> andPerform: anObject [

	self action: anObject
]

{ #category : #accessing }
GLMPhlowTransmission >> destination [

	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destination: aPort [ 
	 
	destination := aPort
]

{ #category : #scripting }
GLMPhlowTransmission >> from: anObject [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"anObject must have an instance variable named #selection to allow default transmissions"
	^ self from: anObject slot: #selection
]

{ #category : #'scripting-depreciated' }
GLMPhlowTransmission >> from: anObject port: aSlotSymbol [

	^ self from: anObject port: aSlotSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> from: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	^ self origins add: (GLMPhlowPortIdentifier essence: anObject slot: aSlotSymbol)
]

{ #category : #accessing }
GLMPhlowTransmission >> origins [

	^ origins ifNil: [ origins := OrderedCollection new ]
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"anObject must have an instance variable named #selection to allow default transmissions"
	^ self to: anObject slot: #selection
]

{ #category : #'scripting-depreciated' }
GLMPhlowTransmission >> to: anObject port: aPortSymbol [
	
	^ self to: anObject slot: aPortSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait for example GLMBrick"
	"aSlotSymbol must be a name of existing Slot in anObject"
	^ self destination: (GLMPhlowPortIdentifier essence: anObject slot: aSlotSymbol)
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation [

	^ transformation
]

{ #category : #accessing }
GLMPhlowTransmission >> transformation: anObject [ 
	 
	transformation := anObject
]

{ #category : #scripting }
GLMPhlowTransmission >> transformed: anObject [

	self transformation: anObject
]

{ #category : #transmitting }
GLMPhlowTransmission >> transmit: aValue [

	self flag: '(self transformation cull: aValue) is for fast testing. Will be changed to phlowValue:'.
	self flag: 'This method will be changed. Just to test API'.
	self destination ifNotNil: [ 
		self destination slot write: (self transformation cull: aValue) to: self destination essence ].
	self action cull: aValue
	
]
