Extension { #name : #GLMCustomRow }

{ #category : #'*Glamour-Scripting' }
GLMCustomRow >> column: aBlockOrSymbol [ 
	 
	^self addColumn: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMCustomRow >> column: aBlockOrSymbol size: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMCustomRow >> column: aBlockOrSymbol span: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol span: anInteger
]
