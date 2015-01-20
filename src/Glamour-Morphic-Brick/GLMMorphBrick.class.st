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

{ #category : #'instance creation' }
GLMMorphBrick class >> on: aMorph [

	^ self new on: aMorph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> brickBounds: aRectangle [
	super brickBounds: aRectangle.
	
	self morph privateBounds: self globalBounds
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> doLayout [
	
	self morph privateBounds: self globalBounds
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
	self addBrickBack: morph.
	super brickBounds: (0@0 extent: (morph width@morph height)).
]
