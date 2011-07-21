Extension { #name : #TextColor }

{ #category : #'*glamour-seaside-rendering' }
TextColor >> cssPropertyAndValue [

	^ ('color' -> ( self color glmAsHtmlColor))
]
