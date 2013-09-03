Extension { #name : #GLMMorphicRenderer }

{ #category : #'*glamour-chartet-presentations' }
GLMMorphicRenderer >> renderChartetPresentation: aGLMChartetPresentation [ 
	^ GLMMorphicChartetRenderer render: aGLMChartetPresentation from: self
]
