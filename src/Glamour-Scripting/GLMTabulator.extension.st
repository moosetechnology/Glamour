Extension { #name : #GLMTabulator }

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> column: aBlockOrSymbol [ 
	 
	^self addColumn: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> column: aBlockOrSymbol size: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> column: aBlockOrSymbol span: anInteger [ 
	 
	^self addColumn: aBlockOrSymbol span: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> initializeScriptingDefaults [ 
	 
	super initializeScriptingDefaults. 
	self cell isNil ifTrue: [self addColumn: #pane].
	self transmissions 
		detect: [ :each | each originatesAt: (self pane port: #entity) ]
		ifNone: [
			self 
				showOn: (self panes first port: #entity);
				from: #outer->#entity;
				using: [ self custom: GLMFlexiblePresentation new ] ]
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> row: aBlockOrSymbol [ 
	 
	^self addRow: aBlockOrSymbol
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> row: aBlockOrSymbol size: anInteger [ 
	 
	^self addRow: aBlockOrSymbol size: anInteger
]

{ #category : #'*Glamour-Scripting' }
GLMTabulator >> row: aBlockOrSymbol span: anInteger [ 
	 
	^self addRow: aBlockOrSymbol span: anInteger
]
