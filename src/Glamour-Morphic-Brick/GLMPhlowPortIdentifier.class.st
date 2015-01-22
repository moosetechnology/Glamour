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
		'essence',
		'slot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowPortIdentifier class >> essence: anObject slot: aSlotSymbol [

	^ self new essence: anObject; slot: ((anObject class slotNamed: aSlotSymbol)); yourself
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> essence [

	^ essence
]

{ #category : #accessing }
GLMPhlowPortIdentifier >> essence: anObject [
	"anObject must be an instance of class having GLMPhlowTrait"
	
	essence := anObject
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
