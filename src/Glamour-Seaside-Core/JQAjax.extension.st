Extension { #name : #JQAjax }

{ #category : #'*Glamour-Seaside-Core' }
JQAjax >> sglCallbackText: aBlock [
	self 
		type: 'POST';
		addParameters: ( GRSmallDictionary new
			at: 'text' put: (JSStream on: 'arguments[0]');
			yourself);
		script: [ :script | 
			aBlock value: (self requestContext request at: 'text') value: script ]
					
]
