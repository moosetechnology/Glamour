"
asdads
"
Class {
	#name : #GLMPhlowTransmission,
	#superclass : #Object,
	#instVars : [
		'receiver',
		'destinationPort',
		'destination'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #accessing }
GLMPhlowTransmission >> destination [

	^ destination
]

{ #category : #accessing }
GLMPhlowTransmission >> destinationPort [

	^ destinationPort
]

{ #category : #scripting }
GLMPhlowTransmission >> to: anObject port: aPortSymbol [

	destination := WeakValueAssociation key: #destination value: anObject.
	destinationPort := aPortSymbol
]
