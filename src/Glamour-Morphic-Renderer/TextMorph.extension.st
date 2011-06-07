Extension { #name : #TextMorph }

{ #category : #'*glamour-morphic-renderer' }
TextMorph >> setOptimalResizing [
	self hResizing: #rigid.
	self vResizing: #rigid
]
