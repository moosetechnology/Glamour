Extension { #name : #GLMMorphicRenderer }

{ #category : #'*Glamour-FastTable' }
GLMMorphicRenderer >> renderFastListPresentation: aPresentation [ 
	^ GLMMorphicFastListRenderer render: aPresentation from: self
]

{ #category : #'*Glamour-FastTable' }
GLMMorphicRenderer >> renderFastTablePresentation: aPresentation [ 
	^ GLMMorphicFastTableRenderer render: aPresentation from: self
]

{ #category : #'*Glamour-FastTable' }
GLMMorphicRenderer >> renderFastTreePresentation: aPresentation [ 
	^ GLMMorphicFastTreeRenderer render: aPresentation from: self
]
