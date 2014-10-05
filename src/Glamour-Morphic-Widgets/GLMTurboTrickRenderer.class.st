Class {
	#name : #GLMTurboTrickRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Widgets-Turbo-Model'
}

{ #category : #rendering }
GLMTurboTrickRenderer class >> render: aTrick on: aCanvas [
	
	self renderColorOf: aTrick on: aCanvas.
	self renderImageOf: aTrick on: aCanvas.
]

{ #category : #rendering }
GLMTurboTrickRenderer class >> renderColorOf: aTrick on: aCanvas [
	|color|
	
	color := aTrick currentColor.
	color ifNotNil: [ aCanvas fillRectangle: aTrick bounds color: color ].
]

{ #category : #rendering }
GLMTurboTrickRenderer class >> renderImageOf: aTrick on: aCanvas [
	|image|
	
	image := aTrick currentImage.
	
	image ifNotNil: [
		aCanvas 
			translucentImage: (GLMTurboTrick resizeImage: image scale: (aTrick bounds extent / image extent))
			at: aTrick bounds origin.
	].
]

{ #category : #'as yet unclassified' }
GLMTurboTrickRenderer >> render: aTrick on: aCanvas [
	
	self renderColorOf: aTrick on: aCanvas.
	self renderImageOf: aTrick on: aCanvas.
]

{ #category : #'as yet unclassified' }
GLMTurboTrickRenderer >> renderColorOf: aTrick on: aCanvas [
	self class renderColorOf: aTrick on: aCanvas
]

{ #category : #'as yet unclassified' }
GLMTurboTrickRenderer >> renderImageOf: aTrick on: aCanvas [
	self class renderImageOf: aTrick on: aCanvas
]
