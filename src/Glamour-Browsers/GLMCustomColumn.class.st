Class {
	#name : #GLMCustomColumn,
	#superclass : #GLMCustomCell,
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLMCustomColumn >> addRow: aBlockOrSymbol [ 
	 
	| newRow cell | 
	cell _ aBlockOrSymbol isSymbol 
		ifTrue: 
			[self browser 
				addPane: 
					((GLMPane new) 
						name: aBlockOrSymbol; 
						yourself). 
			(GLMCustomRow new) 
				id: aBlockOrSymbol; 
				browser: self browser] 
		ifFalse: 
			[newRow _ GLMCustomRow new browser: self browser. 
			aBlockOrSymbol value: newRow. 
			newRow]. 
	self children addLast: cell. 
	^cell
]

{ #category : #accessing }
GLMCustomColumn >> addRow: aBlockOrSymbol span: anInteger [ 
	 
	^(self addRow: aBlockOrSymbol) span: anInteger
]

{ #category : #testing }
GLMCustomColumn >> isColumn [ 
	 
	^true
]
