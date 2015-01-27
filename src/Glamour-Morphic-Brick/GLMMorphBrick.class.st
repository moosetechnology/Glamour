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
	#category : #'Glamour-Morphic-Brick-Morphic'
}

{ #category : #'instance creation' }
GLMMorphBrick class >> on: aMorph [

	^ self new on: aMorph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> brickBounds: aRectangle [
	|origin corner newBounds|
	super brickBounds: aRectangle.
	
	origin := self paddingLeft @ self paddingTop.
	corner := self paddingRight @ self paddingBottom.
	newBounds := self globalBounds.
	newBounds := ((newBounds origin + origin) corner: (newBounds corner - corner)).
	
	self morph bounds: newBounds
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> doLayout [
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> drawSubmorphsOn: aCanvas [
	
	self morph fullDrawOn: (aCanvas copy setOrigin: (aCanvas origin + self bounds origin - self morph bounds origin) clipRect: (aCanvas clipRect translateBy: aCanvas origin))
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> morph [

	^ morph
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> on: aMorph [
	
	aMorph layoutProperties ifNil: [ 
		aMorph layoutProperties: GLMBrickLayoutProperties new.
		aMorph layoutProperties horizontalPercent: 100.
		aMorph layoutProperties verticalPercent: 100 ].
	self layoutProperties: aMorph layoutProperties.

	morph := aMorph.
	morph layoutProperties: (GLMBrickLayoutProperties new).
	morph layoutProperties horizontalPercent: 100.
	morph layoutProperties verticalPercent: 100.
	self addMorphBack: morph.
	super brickBounds: (0@0 extent: (morph width@morph height)).
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> onThemerChanged [
	
]

{ #category : #'as yet unclassified' }
GLMMorphBrick >> themerChanged [
]