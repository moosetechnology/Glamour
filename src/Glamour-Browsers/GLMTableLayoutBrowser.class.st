Class {
	#name : #GLMTableLayoutBrowser,
	#superclass : #GLMExplicitBrowser,
	#instVars : [
		'cell'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #layout }
GLMTableLayoutBrowser >> addColumn: aBlockOrSymbol [ 
	 
	^self cellOrRow addColumn: aBlockOrSymbol
]

{ #category : #layout }
GLMTableLayoutBrowser >> addColumn: aBlockOrSymbol size: anInteger [ 
	 
	^(self addColumn: aBlockOrSymbol) size: anInteger; span: 0
]

{ #category : #layout }
GLMTableLayoutBrowser >> addColumn: aBlockOrSymbol span: anInteger [ 
	 
	^(self addColumn: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLMTableLayoutBrowser >> addRow: aBlockOrSymbol [ 
	 
	^self cellOrColumn addRow: aBlockOrSymbol
]

{ #category : #layout }
GLMTableLayoutBrowser >> addRow: aBlockOrSymbol size: anInteger [ 
	 
	^(self addRow: aBlockOrSymbol) size: anInteger; span: 0
]

{ #category : #layout }
GLMTableLayoutBrowser >> addRow: aBlockOrSymbol span: anInteger [ 
	 
	^(self addRow: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLMTableLayoutBrowser >> cell [ 
	 
	^cell
]

{ #category : #private }
GLMTableLayoutBrowser >> cellOrColumn [ 
	 
	^cell ifNil: [cell := GLMCustomColumn new browser: self]
]

{ #category : #private }
GLMTableLayoutBrowser >> cellOrRow [ 
	 
	^cell ifNil: [cell := GLMCustomRow new browser: self]
]

{ #category : #'scripting-private' }
GLMTableLayoutBrowser >> initializeScriptingDefaults [ 
	 
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
GLMTableLayoutBrowser >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderTableLayoutBrowser: self
]

{ #category : #accessing }
GLMTableLayoutBrowser >> updateContextWith: aPane [ 
	context isNil ifTrue: [context := OrderedCollection new].
	context add: aPane
]
