Extension { #name : #GLMAction }

{ #category : #'*glamour-seaside-rendering' }
GLMAction >> seasideAnchorFrom: actionPresenter on: html [ 

	|tmpAnchor|
	tmpAnchor := html anchor.
	tmpAnchor 
		action: (actionPresenter actionScriptFor: self with: html).
	^ tmpAnchor
]
