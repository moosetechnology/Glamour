Extension { #name : #GLMCustomRow }

{ #category : #'*Glamour-Scripting' }
GLMCustomRow >> column: aBlockOrSymbol [ 
	 
	^self addColumn: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMCustomRow >> column: aBlockOrSymbol span: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol span: anInteger
]
