Class {
	#name : #GLMBrickListAdapter,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Model'
}

{ #category : #private }
GLMBrickListAdapter >> itemMorphAt: anInteger recycled: aMorph [

	self subclassResponsibility
]

{ #category : #private }
GLMBrickListAdapter >> itemsCount [

	^ self subclassResponsibility
]
