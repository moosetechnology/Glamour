Extension { #name : #PanelMorph }

{ #category : #'*glamour-morphic-renderer' }
PanelMorph >> returnToOldResizingStrategy: aCollection [

	|tmpSubmorphResizing|
	self submorphs with: aCollection third do: [:aMorph :resizingParameter |
		aMorph returnToOldResizingStrategy: resizingParameter.
		].
	self hResizing: aCollection first.
	self vResizing: aCollection second.
]

{ #category : #'*glamour-morphic-renderer' }
PanelMorph >> setOptimalResizingStrategyAndReturnOldOne [

	|tmpHResizing tmpVResizing tmpSubmorphResizing |
	tmpHResizing := self hResizing.
	tmpVResizing := self vResizing. 
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap.
	tmpSubmorphResizing := self submorphs collect: [:aMorph |
		aMorph setOptimalResizingStrategyAndReturnOldOne 
		].	
	^ {tmpHResizing. tmpVResizing. tmpSubmorphResizing } 
	
]
