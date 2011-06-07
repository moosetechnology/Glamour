Extension { #name : #SimpleButtonMorph }

{ #category : #'*glamour-morphic-renderer' }
SimpleButtonMorph >> setOptimalResizing [
	self hResizing: #rigid.
	self vResizing: #rigid
]
