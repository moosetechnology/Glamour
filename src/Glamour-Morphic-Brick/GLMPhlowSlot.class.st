"
asdsdfs

asdsf
s
df
s
"
Class {
	#name : #GLMPhlowSlot,
	#superclass : #InstanceVariableSlot,
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #printing }
GLMPhlowSlot >> definitionString [
	"for Slots, the printString is the defintion"
	^self printString
]

{ #category : #testing }
GLMPhlowSlot >> isSpecial [
	"I am more than just a backward compatible ivar slot"
	^true
]

{ #category : #testing }
GLMPhlowSlot >> isVirtual [
	^ false
]

{ #category : #'meta-object-protocol' }
GLMPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject slot: self changedWith: aValue.
	^ result
]
