Extension { #name : #Text }

{ #category : #'*glamour-seaside-rendering' }
Text >> cssDictionary [

	"for now we only check the first character text attributes that we will applied to the full text"
	^ self cssDictionaryAt: 1
]

{ #category : #'*glamour-seaside-rendering' }
Text >> cssDictionaryAt: anIndex [

	"return the css dictionary for the character at anIndex"
	|tmpDictionary|
	tmpDictionary := Dictionary new.
	(self attributesAt: anIndex) do: [:aTextAttribute |
		tmpDictionary at: aTextAttribute cssPropertyAndValue key put: aTextAttribute cssPropertyAndValue value 
		].
	^ tmpDictionary
		
]

{ #category : #'*glamour-seaside-rendering' }
Text >> cssDictionaryForFullText [

	"return a css dictionary for attributes that are applied for the full text"
	|tmpAttributes tmpDictionary|
	tmpDictionary := Dictionary new.
	tmpAttributes := (self attributesAt: 1) asOrderedCollection.
	1 to: self size do: [:tmpIndex |
		|tmpToRemove|
		tmpToRemove := OrderedCollection new.
		tmpAttributes do: [:aTextAttribute |
			((self attributesAt: tmpIndex) includes: aTextAttribute) 
				ifFalse: [tmpToRemove add: aTextAttribute]
			].
		tmpToRemove do: [:aTextAttribute |
			tmpAttributes remove: aTextAttribute
			] 
		].
	tmpAttributes do: [:aTextAttribute |
		tmpDictionary at: aTextAttribute cssPropertyAndValue key put: aTextAttribute cssPropertyAndValue value.
		].
	^ tmpDictionary
]
