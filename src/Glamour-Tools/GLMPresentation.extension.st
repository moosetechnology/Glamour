Extension { #name : #GLMPresentation }

{ #category : #'*glamour-tools' }
GLMPresentation >> viewNested [

	| view |
	view := ROMondrianViewBuilder new.
	self viewNestedOn: view.
	^ view open setLabel: 'Nested'.
]

{ #category : #'*glamour-tools' }
GLMPresentation >> viewNestedOn: view [
	view shape label text: [:each | each class name removePrefix: 'GLM'].
	view node: self
]
