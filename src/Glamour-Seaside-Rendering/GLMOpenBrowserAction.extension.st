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
		action: (html jQuery ajax
					script: [:script| 
						"we do nothing here. As we have to open a new window, all will be done in the callback of the anchor. But I still have to specify this empty action so that the current page do not go jump the called component (I don't know why)"
						] );
		callback: [
			actionPresenter session presenter call: (SGLCalledComponent new browser: (self actOn: actionPresenter presentation) ; yourself)
			].
	^ tmpAnchor
]
