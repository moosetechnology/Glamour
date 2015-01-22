"
asdsdf
"
Class {
	#name : #PhlowSlot,
	#superclass : #InstanceVariableSlot,
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #'as yet unclassified' }
PhlowSlot >> read: anObject [
	('read ', self name) logCr.
	^ anObject instVarAt: index
]

{ #category : #'meta-object-protocol' }
PhlowSlot >> write: aValue to: anObject [
	|result|
	('write ',anObject asString, ' to ', self name) logCr.
	result := anObject instVarAt: index put: aValue.
	('write ',anObject asString, ' to ', self name) logCr.
	^ result
]
