Class {
	#name : #GLMBrickThemer,
	#superclass : #Object,
	#traits : 'GLMBrickScrollpaneStyle + GLMBrickRubricStyle',
	#classTraits : 'GLMBrickScrollpaneStyle classTrait + GLMBrickRubricStyle classTrait',
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

{ #category : #accessing }
GLMBrickThemer class >> reset [

	default := nil
]

{ #category : #brick }
GLMBrickThemer >> backgroundColor [

	^ Color transparent
]

{ #category : #brick }
GLMBrickThemer >> contentBackgroundColor [

	^ Color white
]

{ #category : #brick }
GLMBrickThemer >> textColor [

	^ Color black
]
