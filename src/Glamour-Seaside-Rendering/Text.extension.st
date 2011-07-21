Extension { #name : #Text }

{ #category : #'*glamour-seaside-rendering' }
Text >> cssDictionary [

	"for now we only check the first character text attributes that we will applied to the full text"
	|tmpDictionary|
	tmpDictionary := Dictionary new.
	(self attributesAt: 1) do: [:aTextAttribute |
		tmpDictionary at: aTextAttribute cssPropertyAndValue key put: aTextAttribute cssPropertyAndValue value 
		].
	^ tmpDictionary
		
]
