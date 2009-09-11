Extension { #name : #GLMCustomColumn }

{ #category : #'*Glamour-Scripting' }
GLMCustomColumn >> row: aBlockOrSymbol [ 
	 
	^self addRow: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMCustomColumn >> row: aBlockOrSymbol span: anInteger [ 
	 
	^self addRow: aBlockOrSymbol span: anInteger
]
