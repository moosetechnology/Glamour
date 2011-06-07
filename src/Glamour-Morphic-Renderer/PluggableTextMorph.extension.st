Extension { #name : #PluggableTextMorph }

{ #category : #'*glamour-morphic-renderer' }
PluggableTextMorph >> setOptimalResizing [
	self hResizing: #rigid.
	self vResizing: #rigid
]
