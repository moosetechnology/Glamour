Extension { #name : #GLMPresentation }

{ #category : #'*glamour-tools' }
GLMPresentation >> viewOn: view [
	view shape label text: [:each | each class name removePrefix: 'GLM'].
	view node: self
]
