Extension { #name : #GLMOpenBrowserAction }

{ #category : #'*glamour-morphic-renderer' }
GLMOpenBrowserAction >> morphicActOn: aPresentation [

	^ (self actOn: aPresentation) open
]
