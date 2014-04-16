Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-Morphic-Pager-Glamour' }
GLMMorphicRenderer >> renderNewFinder: aBrowser [ 
	^ aBrowser hasFixedSizePanes 
		ifTrue: [GLMMorphicPagerFinderRenderer render: aBrowser from: self]
		ifFalse: []
]
