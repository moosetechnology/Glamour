Extension { #name : #TextEmphasis }

{ #category : #'*glamour-seaside-rendering' }
TextEmphasis >> cssPropertyAndValue [

	| strm |
	emphasisCode = 1 ifTrue: [^ ('font-weight' -> 'bold') ].
	emphasisCode = 2 ifTrue: [^ ('font-style' -> 'italic') ].
	emphasisCode = 4 ifTrue: [^ ('text-decoration' -> 'underline')].
	emphasisCode = 16 ifTrue: [^ ('text-decoration' -> 'line-through')].
	^ (nil -> nil)
]
