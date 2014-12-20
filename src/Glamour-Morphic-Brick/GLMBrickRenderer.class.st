"
A GLMBrickRenderer is most simple separate renderer of Bricks. It support only borders

"
Class {
	#name : #GLMBrickRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #rendering }
GLMBrickRenderer class >> render: aBrick on: aCanvas [
	
	self renderBackgroundColorOf: aBrick on: aCanvas.
	self renderBorderOf: aBrick on: aCanvas.
]

{ #category : #'as yet unclassified' }
GLMBrickRenderer class >> renderBackgroundColorOf: aBrick on: aCanvas [

	aCanvas surface fillRectangle: (0@0 extent: aBrick brickBounds extent) withSolidColor: aBrick color
]

{ #category : #rendering }
GLMBrickRenderer class >> renderBorderOf: aBrick on: aCanvas [
	|rect|
	
	rect := (aBrick brickBounds origin - (aBrick layoutProperties paddingLeft @ aBrick layoutProperties paddingTop)) corner: (aBrick brickBounds corner + (aBrick layoutProperties paddingRight @ aBrick layoutProperties paddingBottom)).

	"aCanvas frameRectangle: rect width: aBrick borderWidth color: aBrick borderColor"
]

{ #category : #rendering }
GLMBrickRenderer >> render: aBrick on: aCanvas [
	
	self renderBackgroundColorOf: aBrick on: aCanvas.
	self renderBorderOf: aBrick on: aCanvas.
]

{ #category : #rendering }
GLMBrickRenderer >> renderBackgroundColorOf: aBrick on: aCanvas [

	aCanvas surface fillRectangle: (0@0 extent: aBrick brickBounds extent) withSolidColor: aBrick color
]

{ #category : #rendering }
GLMBrickRenderer >> renderBorderOf: aBrick on: aCanvas [
	|rect|
	
	rect := (aBrick brickBounds origin - (aBrick layoutProperties paddingLeft @ aBrick layoutProperties paddingTop)) corner: (aBrick brickBounds corner + (aBrick layoutProperties paddingRight @ aBrick layoutProperties paddingBottom)).

	"aCanvas frameRectangle: rect width: aBrick borderWidth color: aBrick borderColor"
]
