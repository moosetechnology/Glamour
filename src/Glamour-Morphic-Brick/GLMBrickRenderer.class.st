"
A GLMBrickRenderer is most simple separate renderer of Bricks. It support only borders

"
Class {
	#name : #GLMBrickRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #rendering }
GLMBrickRenderer >> render: aBrick on: aCanvas [
	
	self
		renderBackgroundColorOf: aBrick on: aCanvas;
		renderBorderOf: aBrick on: aCanvas
]

{ #category : #rendering }
GLMBrickRenderer >> renderBackgroundColorOf: aBrick on: aCanvas [

	aCanvas fillRectangle: aBrick brickBounds color: aBrick color
]

{ #category : #rendering }
GLMBrickRenderer >> renderBorderOf: aBrick on: aCanvas [
	|rect|
	
	rect := (aBrick brickBounds origin - (aBrick paddingLeft @ aBrick paddingTop)) corner: (aBrick brickBounds corner + (aBrick paddingRight @ aBrick paddingBottom)).
	aCanvas frameRectangle: rect width: aBrick borderWidth color: aBrick borderColor
]
