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

{ #category : #accessing }
GLMPhlowSlot >> index [
	^ index
]

{ #category : #accessing }
GLMPhlowSlot >> index: anIndex [
	index := anIndex
]

{ #category : #testing }
GLMPhlowSlot >> isVirtual [
	^ false
]

{ #category : #'meta-object-protocol' }
GLMPhlowSlot >> read: anObject [
	^ anObject instVarAt: index
]

{ #category : #'meta-object-protocol' }
GLMPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject slot: self changedWith: aValue.
	^ result
]
