Extension { #name : #GLMPresentation }

{ #category : #'*glamour-tools' }
GLMPresentation >> viewNestedOn: view [
	view shape label text: [:each | each class name removePrefix: 'GLM'].
	view node: self
]

{ #category : #'*glamour-tools' }
GLMPresentation >> viewTreeOn: view [
	view shape label text: [:each | each class name removePrefix: 'GLM'].
	view node: self
]
