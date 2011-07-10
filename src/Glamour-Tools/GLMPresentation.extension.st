Extension { #name : #GLMPresentation }

{ #category : #'*glamour-tools' }
GLMPresentation >> viewNestedOn: view [
	view shape label text: [:each | each class name removePrefix: 'GLM'].
	view node: self
]
