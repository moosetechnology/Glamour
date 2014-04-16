Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-Morphic-Pager-Glamour' }
GLMMorphicRenderer >> renderPager: aBrowser [ 
	^ aBrowser hasFixedSizePanes 
		ifTrue: [GLMMorphicPagerFinderRenderer render: aBrowser from: self]
		ifFalse: []
]
