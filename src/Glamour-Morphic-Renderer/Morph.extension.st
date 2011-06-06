Extension { #name : #Morph }

{ #category : #'*glamour-morphic-renderer' }
Morph >> glamourOptimalExtent [

	|tmpOldResizing tmpResult|
	tmpOldResizing := self setOptimalResizingStrategyAndReturnOldOne. 
	tmpResult := self minExtent.
	self returnToOldResizingStrategy:  tmpOldResizing.
	^ tmpResult 
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> returnToOldResizingStrategy: aCollection [

	self hResizing: aCollection first.
	self vResizing: aCollection second.
]

{ #category : #'*glamour-morphic-renderer' }
Morph >> setOptimalResizingStrategyAndReturnOldOne [

	|tmpHResizing tmpVResizing  |
	tmpHResizing := self hResizing.
	tmpVResizing := self vResizing. 
	self hResizing: #rigid.
	self vResizing: #rigid.
	^ {tmpHResizing. tmpVResizing. } 
]
