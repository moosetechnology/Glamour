"
asdads
"
Class {
	#name : #GLMBrickThemer,
	#superclass : #Object,
	#traits : 'GLMBrickScrollbarStyle',
	#classTraits : 'GLMBrickScrollbarStyle classTrait',
	#classInstVars : [
		'default'
	],
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #accessing }
GLMBrickThemer class >> default [

	^ default
		ifNil: [ default := self new ]
		ifNotNil: [ default class = self ifTrue: [ default ] ifFalse: [ default := self new ] ]
]

{ #category : #brick }
GLMBrickThemer >> backgroundColor [

	^ Color transparent
]
