Extension { #name : #ImageMorph }

{ #category : #'*glamour-morphic-renderer' }
ImageMorph >> setOptimalResizing [
	self hResizing: #rigid.
	self vResizing: #rigid
]
