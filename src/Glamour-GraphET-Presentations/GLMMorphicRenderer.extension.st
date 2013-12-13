Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-GraphET-Presentations' }
GLMMorphicRenderer >> renderGraphETPresentation: aGLMChartetPresentation [ 
	^ GLMMorphicGraphETRenderer render: aGLMChartetPresentation from: self
]
