Extension { #name : #GLMTableLayoutBrowser }

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> column: aBlockOrSymbol [ 
	 
	^self addColumn: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> column: aBlockOrSymbol size: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> column: aBlockOrSymbol span: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol span: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> row: aBlockOrSymbol [ 
	 
	^self addRow: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> row: aBlockOrSymbol size: anInteger [ 
	 
	^self addRow: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTableLayoutBrowser >> row: aBlockOrSymbol span: anInteger [ 
	 
	^self addRow: aBlockOrSymbol span: anInteger
]
