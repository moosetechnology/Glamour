Trait {
	#name : #GLMCheckBoxStyle,
	#category : #'Glamour-Morphic-Brick-Theme'
}

{ #category : #'brick-checkbox' }
GLMCheckBoxStyle >> checkboxBorderColor [
	^ Color lightGray
]

{ #category : #'brick-checkbox' }
GLMCheckBoxStyle >> checkboxBorderWidth [
	^ 2
]

{ #category : #'brick-checkbox' }
GLMCheckBoxStyle >> checkboxCheckedImage [
	^ GLMUIThemeExtraIcons glamorousAccept
]

{ #category : #'brick-checkbox' }
GLMCheckBoxStyle >> checkboxHeight [
	^ 18
]

{ #category : #'brick-checkbox' }
GLMCheckBoxStyle >> checkboxWidth [
	^ 18
]
