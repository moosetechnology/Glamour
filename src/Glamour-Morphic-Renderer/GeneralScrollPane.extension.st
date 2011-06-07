Extension { #name : #GeneralScrollPane }

{ #category : #'*glamour-morphic-renderer' }
GeneralScrollPane >> minExtent [

	^ self submorphs first minExtent
]
