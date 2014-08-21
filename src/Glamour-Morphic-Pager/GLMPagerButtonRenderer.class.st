Class {
	#name : #GLMPagerButtonRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #rendering }
GLMPagerButtonRenderer >> render: aGLMButton on: aCanvas [
	
	self renderColorOf: aGLMButton on: aCanvas.
	self renderImageOf: aGLMButton on: aCanvas.
]

{ #category : #rendering }
GLMPagerButtonRenderer >> renderColorOf: aGLMButton on: aCanvas [
	|color|
	
	color := aGLMButton currentColor.
	color ifNotNil: [ aCanvas fillRectangle: aGLMButton bounds color: color ].
]

{ #category : #rendering }
GLMPagerButtonRenderer >> renderImageOf: aGLMButton on: aCanvas [
	|image|
	
	image := aGLMButton currentImage.
	
	image ifNotNil: [
		aCanvas 
			translucentImage: (aGLMButton resizeImage: image scale: (aGLMButton bounds extent / image extent))
			at: aGLMButton bounds origin.
	].
]
