"
A GLMPhlowDestinationIdentifier is asda.

Instance Variables
	essence:		<Object>
	port:		<Object>

essence
	- xxxxx

port
	- xxxxx

"
Class {
	#name : #GLMPhlowDestination,
	#superclass : #Object,
	#instVars : [
		'essence',
		'port'
	],
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #'instance creation' }
GLMPhlowDestination class >> essence: anObject port: aPortObject [

	^ self new essence: anObject; port: aPortObject; yourself
]

{ #category : #'instance creation' }
GLMPhlowDestination class >> essence: anObject slot: aSlotSymbol [

	^ self new essence: anObject port: ((anObject class slotNamed: aSlotSymbol)); yourself
]

{ #category : #accessing }
GLMPhlowDestination >> essence [
	^ essence
]

{ #category : #accessing }
GLMPhlowDestination >> essence: anObject [
	"essense must use GLMPhlowTrait"
	essence := anObject
]

{ #category : #'*Glamour-Morphic-Brick' }
GLMPhlowDestination >> phlowValue: anObject [

	self port phlowValue: self essence value: anObject
	
]

{ #category : #accessing }
GLMPhlowDestination >> port [
	^ port
]

{ #category : #accessing }
GLMPhlowDestination >> port: anObject [
	"port can be anything"
	port := anObject
]
