Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-GraphET-Presentations' }
GLMMorphicRenderer >> renderChartetPresentation: aGLMChartetPresentation [ 
	^ GLMMorphicGraphETRenderer render: aGLMChartetPresentation from: self
]
