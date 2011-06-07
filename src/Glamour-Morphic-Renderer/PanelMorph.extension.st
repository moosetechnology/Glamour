Extension { #name : #PanelMorph }

{ #category : #'*glamour-morphic-renderer' }
PanelMorph >> setOptimalResizing [
	self hResizing: #shrinkWrap.
	self vResizing: #shrinkWrap
]
