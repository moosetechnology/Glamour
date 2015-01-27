Class {
	#name : #GLMBrickLayouterNode,
	#superclass : #Object,
	#instVars : [
		'opposite',
		'children',
		'parent',
		'brick'
	],
	#category : #'Glamour-Morphic-Brick-Layouter'
}

{ #category : #accessing }
GLMBrickLayouterNode >> brick [
	^ brick
]

{ #category : #accessing }
GLMBrickLayouterNode >> brick: anObject [
	brick := anObject
]

{ #category : #accessing }
GLMBrickLayouterNode >> children [
	^ children
]

{ #category : #accessing }
GLMBrickLayouterNode >> children: anObject [
	children := anObject
]

{ #category : #accessing }
GLMBrickLayouterNode >> opposite [
	^ opposite
]

{ #category : #accessing }
GLMBrickLayouterNode >> opposite: anObject [
	opposite := anObject
]

{ #category : #accessing }
GLMBrickLayouterNode >> parent [
	^ parent
]

{ #category : #accessing }
GLMBrickLayouterNode >> parent: anObject [
	parent := anObject
]
