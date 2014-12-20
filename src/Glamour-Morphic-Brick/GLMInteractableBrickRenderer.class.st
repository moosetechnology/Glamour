"
A GLMInteractableBrickRenderer is more advanced Brick renderer, that is used in all interactable Bricks to allow on-fly change of background color or image

"
Class {
	#name : #GLMInteractableBrickRenderer,
	#superclass : #GLMBrickRenderer,
	#category : #'Glamour-Morphic-Brick-Renderer'
}

{ #category : #rendering }
GLMInteractableBrickRenderer class >> render: aBrick on: aCanvas [

	self renderBackgroundColorOf: aBrick on: aCanvas.
	self renderColorOf: aBrick on: aCanvas.
	self renderImageOf: aBrick on: aCanvas.
	self renderBorderOf: aBrick on: aCanvas.
]

{ #category : #rendering }
GLMInteractableBrickRenderer class >> renderColorOf: aBrick on: aCanvas [
	|color|
	
	color := aBrick currentColor.
	color ifNotNil: [	aCanvas surface fillRectangle: (0@0 extent: aBrick brickBounds extent) withSolidColor: color ].
]

{ #category : #rendering }
GLMInteractableBrickRenderer class >> renderImageOf: aBrick on: aCanvas [
	|image|
	
	image := aBrick currentImage.
	
	image ifNotNil: [
		aCanvas setPaint: (GLMBrick resizeImage: image scale: (aBrick extent / image extent)).
		aCanvas draw ].
]

{ #category : #rendering }
GLMInteractableBrickRenderer >> render: aBrick on: aCanvas [
	
	self renderBackgroundColorOf: aBrick on: aCanvas.
	self renderColorOf: aBrick on: aCanvas.
	self renderImageOf: aBrick on: aCanvas.
	self renderBorderOf: aBrick on: aCanvas.
]

{ #category : #rendering }
GLMInteractableBrickRenderer >> renderColorOf: aBrick on: aCanvas [
	self class renderColorOf: aBrick on: aCanvas
]

{ #category : #rendering }
GLMInteractableBrickRenderer >> renderImageOf: aBrick on: aCanvas [
	self class renderImageOf: aBrick on: aCanvas
]
