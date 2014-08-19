Class {
	#name : #GLMPagerButtonRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #rendering }
GLMPagerButtonRenderer >> render: aGLMButton on: aCanvas [
	|image color|
	
	image := aGLMButton currentImage.
	color := aGLMButton currentColor.
	
	color ifNotNil: [ aCanvas fillRectangle: aGLMButton bounds color: color ].
	
	image ifNotNil: [
		aCanvas 
			translucentImage: (aGLMButton resizeImage: image scale: (aGLMButton bounds extent / image extent))
			at: aGLMButton bounds origin.
	].
]
