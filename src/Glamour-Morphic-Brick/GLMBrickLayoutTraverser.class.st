Class {
	#name : #GLMBrickLayoutTraverser,
	#superclass : #Object,
	#instVars : [
		'traverser'
	],
	#category : #'Glamour-Morphic-Brick-Layouter'
}

{ #category : #'as yet unclassified' }
GLMBrickLayoutTraverser >> layoutFrom: aBrick [
]

{ #category : #'as yet unclassified' }
GLMBrickLayoutTraverser >> traverser [

	^ traverser ifNil: [ traverser := GLMBrickHeightTraverser new ]
]
