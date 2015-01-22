"
asdsdfs

asdsf
s
df
s
"
Class {
	#name : #GLMAPhlowSlot,
	#superclass : #Slot,
	#category : #'Glamour-Morphic-Brick-Phlowr'
}

{ #category : #accessing }
GLMAPhlowSlot >> index [
	^ index
]

{ #category : #accessing }
GLMAPhlowSlot >> index: anIndex [
	index := anIndex
]

{ #category : #'meta-object-protocol' }
GLMAPhlowSlot >> read: anObject [
	^ anObject instVarAt: index
]

{ #category : #'meta-object-protocol' }
GLMAPhlowSlot >> write: aValue to: anObject [
	|result|
	result := anObject instVarAt: index put: aValue.
	anObject slot: self changedWith: aValue.
	^ result
]
