Extension { #name : #GLMOpenBrowserAction }

{ #category : #'*glamour-seaside-rendering' }
GLMOpenBrowserAction >> seasideAnchorFrom: actionPresenter on: html [ 

	|tmpAnchor|
	tmpAnchor := html popupAnchor 
					extent: 300@300;
					resizable: true;
					dependent: true;
					yourself.
	tmpAnchor 
		callback: [
			actionPresenter session presenter show: WACounter new"(SGLCalledComponent new browser: (self actOn: actionPresenter presentation) ; yourself)"
			].
	^ tmpAnchor
]
