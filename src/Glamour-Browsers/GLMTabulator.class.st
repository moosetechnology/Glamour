Class {
	#name : #GLMTabulator,
	#superclass : #GLMExplicitBrowser,
	#instVars : [
		'cell'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #layout }
GLMTabulator >> addColumn: aBlockOrSymbol [ 
	 
	^self cellOrRow addColumn: aBlockOrSymbol
]

{ #category : #layout }
GLMTabulator >> addColumn: aBlockOrSymbol size: anInteger [ 
	 
	^(self addColumn: aBlockOrSymbol) size: anInteger; span: 0
]

{ #category : #layout }
GLMTabulator >> addColumn: aBlockOrSymbol span: anInteger [ 
	 
	^(self addColumn: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLMTabulator >> addRow: aBlockOrSymbol [ 
	 
	^self cellOrColumn addRow: aBlockOrSymbol
]

{ #category : #layout }
GLMTabulator >> addRow: aBlockOrSymbol size: anInteger [ 
	 
	^(self addRow: aBlockOrSymbol) size: anInteger; span: 0
]

{ #category : #layout }
GLMTabulator >> addRow: aBlockOrSymbol span: anInteger [ 
	 
	^(self addRow: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLMTabulator >> cell [ 
	 
	^cell
]

{ #category : #private }
GLMTabulator >> cellOrColumn [ 
	 
	^cell ifNil: [cell := GLMCustomColumn new browser: self]
]

{ #category : #private }
GLMTabulator >> cellOrRow [ 
	 
	^cell ifNil: [cell := GLMCustomRow new browser: self]
]

{ #category : #'scripting-private' }
GLMTabulator >> initializeScriptingDefaults [ 
	 
	super initializeScriptingDefaults. 
	self cell isNil ifTrue: [self addColumn: #pane]. 
	self jumpstartTransmissions isEmpty 
		ifTrue: 
			[self 
				addJumpstart: 
					((GLMBundleTransmission new) 
						destination: (self panes first port: #entity); 
						addPresentation: GLMFlexiblePresentation new; 
						yourself)]
]

{ #category : #rendering }
GLMTabulator >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderTableLayoutBrowser: self
]

{ #category : #accessing }
GLMTabulator >> updateContextWith: aPane [ 
	context isNil ifTrue: [context := OrderedCollection new].
	context add: aPane
]
