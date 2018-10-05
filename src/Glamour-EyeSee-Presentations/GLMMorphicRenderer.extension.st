Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-EyeSee-Presentations' }
GLMMorphicRenderer >> renderEyeSeePresentation: aPresentation [
	^ GLMMorphicEyeSeeRenderer render: aPresentation from: self
]
