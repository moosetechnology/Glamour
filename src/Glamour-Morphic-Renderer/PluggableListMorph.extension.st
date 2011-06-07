Extension { #name : #PluggableListMorph }

{ #category : #'*glamour-morphic-renderer' }
PluggableListMorph >> setOptimalResizing [
	self hResizing: #rigid.
	self vResizing: #rigid
]
