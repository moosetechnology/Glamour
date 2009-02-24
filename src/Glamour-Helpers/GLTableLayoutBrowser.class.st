Class {
	#name : #GLTableLayoutBrowser,
	#superclass : #GLExplicitBrowser,
	#instVars : [
		'cell'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #layout }
GLTableLayoutBrowser >> addColumn: aBlockOrSymbol [
	
	^self cellOrRow addColumn: aBlockOrSymbol
]

{ #category : #layout }
GLTableLayoutBrowser >> addColumn: aBlockOrSymbol span: anInteger [
	
	^(self addColumn: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLTableLayoutBrowser >> addRow: aBlockOrSymbol [
	
	^self cellOrColumn addRow: aBlockOrSymbol
]

{ #category : #layout }
GLTableLayoutBrowser >> addRow: aBlockOrSymbol span: anInteger [
	
	^(self addRow: aBlockOrSymbol) span: anInteger
]

{ #category : #layout }
GLTableLayoutBrowser >> cell [
	
	^cell
]

{ #category : #private }
GLTableLayoutBrowser >> cellOrColumn [
	
	^cell ifNil: [cell := GLCustomColumn new browser: self]
]

{ #category : #private }
GLTableLayoutBrowser >> cellOrRow [
	
	^cell ifNil: [cell := GLCustomRow new browser: self]
]

{ #category : #scripting }
GLTableLayoutBrowser >> column: aBlockOrSymbol [
	
	^self addColumn: aBlockOrSymbol
]

{ #category : #scripting }
GLTableLayoutBrowser >> column: aBlockOrSymbol span: anInteger [
	
	^self addColumn: aBlockOrSymbol span: anInteger
]

{ #category : #'scripting-private' }
GLTableLayoutBrowser >> initializeScriptingDefaults [
	
	super initializeScriptingDefaults.
	self cell isNil ifTrue: [self addColumn: #pane].
	self jumpstartTransmissions isEmpty
		ifTrue:
			[self
				addJumpstart:
					((GLBundleTransmission new)
						destination: (self panes first port: #entity);
						addPresentation: GLFlexiblePresentation new;
						yourself)]
]

{ #category : #rendering }
GLTableLayoutBrowser >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderTableLayoutBrowser: self
]

{ #category : #scripting }
GLTableLayoutBrowser >> row: aBlockOrSymbol [
	
	^self addRow: aBlockOrSymbol
]

{ #category : #scripting }
GLTableLayoutBrowser >> row: aBlockOrSymbol span: anInteger [
	
	^self addRow: aBlockOrSymbol span: anInteger
]
