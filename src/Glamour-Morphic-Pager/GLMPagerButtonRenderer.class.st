Class {
	#name : #GLMPagerButtonRenderer,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #rendering }
GLMPagerButtonRenderer >> render: aGLMButton on: aCanvas [
	|image|
	image := aGLMButton currentImage.
	image ifNotNil: [
		aCanvas 
			translucentImage: (aGLMButton resizeImage: image scale: (aGLMButton bounds extent / image extent))
			at: aGLMButton bounds origin.
	].
]
