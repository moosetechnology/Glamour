Extension { #name : #String }

{ #category : #'*glamour-seaside-rendering' }
String >> cssDictionary [

	"a string has no attributes"
	^ Dictionary new
]

{ #category : #'*glamour-seaside-rendering' }
String >> cssDictionaryAt: anIndex [

	"a string has no attributes"
	^ Dictionary new
]

{ #category : #'*glamour-seaside-rendering' }
String >> cssDictionaryForFullText [ 

	"a string has no attributes"
	^ Dictionary new
]

{ #category : #'*glamour-seaside-rendering' }
String >> seasideAnchorFrom: actionPresenter on: html [ 

	|tmpAnchor|
	tmpAnchor := html anchor.
	"tmpAnchor 
		action: (actionPresenter actionScriptFor: self with: html)."
	^ tmpAnchor
]
