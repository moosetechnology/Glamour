Extension { #name : #GLMCustomColumn }

{ #category : #'*Glamour-Scripting' }
GLMCustomColumn >> row: aBlockOrSymbol [ 
	 
	^self addRow: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMCustomColumn >> row: aBlockOrSymbol size: anInteger [ 
	 
	^self addRow: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMCustomColumn >> row: aBlockOrSymbol span: anInteger [ 
	 
	^self addRow: aBlockOrSymbol span: anInteger
]
