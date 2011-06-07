Extension { #name : #Morph }

{ #category : #'*glamour-morphic-renderer' }
Morph >> glamourMinExtent [

	^ self minExtent
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> glamourOptimalExtent [

	|tmpOldResizing tmpResult|
	tmpOldResizing := self setOptimalResizingStrategyAndReturnOldOne. 
	tmpResult := self glamourMinExtent.
	self returnToOldResizingStrategy:  tmpOldResizing.
	^ tmpResult 
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> returnToOldResizingStrategy: aCollection [

	|tmpSubmorphResizing|
	self submorphs with: aCollection third do: [:aMorph :resizingParameter |
		aMorph returnToOldResizingStrategy: resizingParameter.
		].
	self hResizing: aCollection first.
	self vResizing: aCollection second.
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> setOptimalResizing [
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> setOptimalResizingStrategyAndReturnOldOne [
	| tmpHResizing tmpVResizing tmpSubmorphResizing |
	tmpHResizing := self hResizing.
	tmpVResizing := self vResizing.
	self setOptimalResizing.
	tmpSubmorphResizing := self submorphs collect: [ :aMorph | aMorph setOptimalResizingStrategyAndReturnOldOne ].
	^ {tmpHResizing.
	tmpVResizing.
	tmpSubmorphResizing}
]
