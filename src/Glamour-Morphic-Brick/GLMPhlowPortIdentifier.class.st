"
A GLMPhlowPortIdentifier is asdad.

Instance Variables
	destination:		<Object>
	slot:		<Object>

destination
	- xxxxx

slot
	- xxxxx

"
Class {
	#name : #GLMPhlowPortIdentifier,
	#superclass : #Object,
	#instVars : [
		'destination',
		'slot'
	],
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #'instance creation' }
GLMPhlowPortIdentifier class >> destination: anObject slot: aSlotSymbol [

	^ self new destination: anObject; slot: ((anObject class slotNamed: aSlotSymbol)); yourself
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> destination [
	^ destination
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> destination: anObject [
	"anObject must be an instance of class having GLMPhlowTrait"
	
	destination := anObject
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> slot [
	^ slot
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> slot: aSlot [
	"aSlot must be an instance of GLMPhlowSlot"
	
	slot := aSlot
]
