Extension { #name : #GLMCompositePresentation }

{ #category : #'*Glamour-Morphic-ToolbarWindow' }
GLMCompositePresentation >> hasToolbar [
	^ self allActions anySatisfy: #isButton
]

{ #category : #'*Glamour-Morphic-ToolbarWindow' }
GLMCompositePresentation >> toolbarPosition [
	"This can be changed (ideally is a configurable attr)"
	^ #top asToolbarPosition
]
