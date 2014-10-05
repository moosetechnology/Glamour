Extension { #name : #GLMMorphicRenderer }

{ #category : #'*glamour-roassal-presentations' }
GLMMorphicRenderer >> renderRoassalPresentation: aPresentation [
	^ GLMMorphicRoassalRenderer render: aPresentation from: self
]
