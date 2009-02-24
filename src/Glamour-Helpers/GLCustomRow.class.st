Class {
	#name : #GLCustomRow,
	#superclass : #GLCustomCell,
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLCustomRow >> addColumn: aBlockOrSymbol [
	
	| newColumn cell |
	cell := aBlockOrSymbol isSymbol
		ifTrue:
			[self browser
				addPane:
					((GLPane new)
						name: aBlockOrSymbol;
						yourself).
			(GLCustomColumn new)
				id: aBlockOrSymbol;
				browser: self browser]
		ifFalse:
			[newColumn := GLCustomColumn new browser: self browser.
			aBlockOrSymbol value: newColumn.
			newColumn].
	self children addLast: cell.
	^cell
]

{ #category : #accessing }
GLCustomRow >> addColumn: aBlockOrSymbol span: anInteger [
	
	^(self addColumn: aBlockOrSymbol) span: anInteger
]

{ #category : #scripting }
GLCustomRow >> column: aBlockOrSymbol [
	
	^self addColumn: aBlockOrSymbol
]

{ #category : #scripting }
GLCustomRow >> column: aBlockOrSymbol span: anInteger [
	
	^self addColumn: aBlockOrSymbol span: anInteger
]

{ #category : #testing }
GLCustomRow >> isRow [
	
	^true
]
