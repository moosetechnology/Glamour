Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-Morphic-Pager-Glamour' }
GLMMorphicRenderer >> renderPager: aBrowser [ 
	^ aBrowser hasFixedSizePanes 
		ifTrue: [GLMMorphicPagerRenderer render: aBrowser from: self]
		ifFalse: []
]
