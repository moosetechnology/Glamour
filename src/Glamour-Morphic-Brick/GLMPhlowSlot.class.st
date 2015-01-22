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
	#category : #'Glamour-Morphic-Brick-Phlow'
}

{ #category : #printing }
GLMPhlowSlot >> definitionString [
	"for Slots, the printString is the defintion"
	^self printString
]

{ #category : #'code generation' }
GLMPhlowSlot >> emitStore: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #writeToSlot:of:
]

{ #category : #'code generation' }
GLMPhlowSlot >> emitValue: aMethodBuilder [
	aMethodBuilder
		pushLiteral: self;
		pushReceiver;
		send: #read:
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

{ #category : #queries }
GLMPhlowSlot >> usingMethods [
	"All methods that read or write the slot"
	^self definingClass 
		ifNil: [ #() ]
		ifNotNil: [:class | class allMethodsAccessingSlot: self].
]

{ #category : #'meta-object-protocol' }
GLMPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject slot: self changedWith: aValue.
	^ result
]
