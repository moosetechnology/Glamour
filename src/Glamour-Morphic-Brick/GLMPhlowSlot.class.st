"
asdsdfs

asdsf
s
df
s
"
Class {
	#name : #GLMPhlowSlot,
	#superclass : #Slot,
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #'as yet unclassified' }
GLMPhlowSlot >> index [
	^ index
]

{ #category : #'as yet unclassified' }
GLMPhlowSlot >> index: anIndex [
	index := anIndex
]

{ #category : #'as yet unclassified' }
GLMPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject slot: self changedWith: aValue.
	^ result
]
