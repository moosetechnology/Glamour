"
A GLMPhlowOriginIdentifier is asdads

Instance Variables
	essence:		<Object>
	slot:		<Object>

essence
	- xxxxx

slot
	- xxxxx

"
Class {
	#name : #GLMPhlowOrigin,
	#superclass : #Object,
	#instVars : [
		'essence',
		'slot'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowOrigin class >> essence: anObject slot: aSlotSymbol [

	^ self new essence: anObject; slot: ((anObject class slotNamed: aSlotSymbol)); yourself
]

{ #category : #accessing }
GLMPhlowOrigin >> essence [
	^ essence
]

{ #category : #accessing }
GLMPhlowOrigin >> essence: anObject [
	essence := anObject
]

{ #category : #accessing }
GLMPhlowOrigin >> slot [
	^ slot
]

{ #category : #accessing }
GLMPhlowOrigin >> slot: anObject [
	"must be a GLMPhlowSlot"
	slot := anObject
]
