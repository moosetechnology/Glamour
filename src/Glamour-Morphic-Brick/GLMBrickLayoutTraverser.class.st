Class {
	#name : #GLMBrickLayoutTraverser,
	#superclass : #Object,
	#instVars : [
		'traverser',
		'brick'
	],
	#category : #'Glamour-Morphic-Brick-Layouter'
}

{ #category : #accessing }
GLMBrickLayoutTraverser >> brick [
	^ brick
]

{ #category : #accessing }
GLMBrickLayoutTraverser >> brick: anObject [
	brick := anObject
]

{ #category : #layouting }
GLMBrickLayoutTraverser >> layoutFrom: aBrick [
]

{ #category : #actions }
GLMBrickLayoutTraverser >> switch [

	self traverser: self traverser opposite
]

{ #category : #accessing }
GLMBrickLayoutTraverser >> traverser [

	^ traverser ifNil: [ traverser := GLMBrickHeightTraverser new ]
]

{ #category : #accessing }
GLMBrickLayoutTraverser >> traverser: aTraverser [

	traverser := aTraverser
]
