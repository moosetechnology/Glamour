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
		'destination'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #accessing }
GLMPhlowTransmission >> destination [

	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destination: aPort [ 
	 
	destination := aPort
]

{ #category : #'scripting-depreciated' }
GLMPhlowTransmission >> from: anObject port: aSlotSymbol [

	^ self from: anObject port: aSlotSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> from: anObject slot: aSlotSymbol [

	^ self origins add: (GLMPhlowPortIdentifier essence: anObject slot: aSlotSymbol)
]

{ #category : #accessing }
GLMPhlowTransmission >> origins [

	^ origins ifNil: [ origins := OrderedCollection new ]
]

{ #category : #'scripting-depreciated' }
GLMPhlowTransmission >> to: anObject port: aPortSymbol [
	
	^ self to: anObject slot: aPortSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	
	^ self destination: (GLMPhlowPortIdentifier essence: anObject slot: aSlotSymbol)
]
