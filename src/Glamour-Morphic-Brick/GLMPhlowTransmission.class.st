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

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject port: aPortSymbol [
	
	^ self to: anObject slot: aPortSymbol
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject slot: aSlotSymbol [
	"anObject must be an instance of class having GLMPhlowTrait"
	"aSlotSymbol must be a name of existing GLMPhlowSlot in anObject"
	
	^ self destination: (GLMPhlowPortIdentifier destination: anObject slot: aSlotSymbol)
]
