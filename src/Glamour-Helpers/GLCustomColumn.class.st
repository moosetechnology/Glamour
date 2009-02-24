Class {
	#name : #GLCustomColumn,
	#superclass : #GLCustomCell,
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLCustomColumn >> addRow: aBlockOrSymbol [
	
	| newRow cell |
	cell := aBlockOrSymbol isSymbol
		ifTrue:
			[self browser
				addPane:
					((GLPane new)
						name: aBlockOrSymbol;
						yourself).
			(GLCustomRow new)
				id: aBlockOrSymbol;
				browser: self browser]
		ifFalse:
			[newRow := GLCustomRow new browser: self browser.
			aBlockOrSymbol value: newRow.
			newRow].
	self children addLast: cell.
	^cell
]

{ #category : #accessing }
GLCustomColumn >> addRow: aBlockOrSymbol span: anInteger [
	
	^(self addRow: aBlockOrSymbol) span: anInteger
]

{ #category : #testing }
GLCustomColumn >> isColumn [
	
	^true
]

{ #category : #scripting }
GLCustomColumn >> row: aBlockOrSymbol [
	
	^self addRow: aBlockOrSymbol
]

{ #category : #scripting }
GLCustomColumn >> row: aBlockOrSymbol span: anInteger [
	
	^self addRow: aBlockOrSymbol span: anInteger
]
