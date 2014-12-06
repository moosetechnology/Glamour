"
A GLMMorphBrick is used as container for morphs to embed them inside bricks

Instance Variables
	morph:		<Object>

morph
	- xxxxx

"
Class {
	#name : #GLMMorphBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'morph'
	],
	#category : #'Glamour-Morphic-Brick-Widgets'
}

{ #category : #'as yet unclassified' }
GLMMorphBrick class >> on: aMorph [

	^ self new on: aMorph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> doLayout [
	
	self layoutPolicy layout: self in: self brickBounds
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> morph [

	^ morph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> on: aMorph [

	morph := aMorph.
	morph layoutProperties: (GLMBrickLayoutProperties new).
	morph layoutProperties horizontalPercent: 100.
	morph layoutProperties verticalPercent: 100.
	self addBrickBack: morph
]
