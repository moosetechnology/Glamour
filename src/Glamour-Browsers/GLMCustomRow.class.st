Class {
	#name : #GLMCustomRow,
	#superclass : #GLMCustomCell,
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLMCustomRow >> addColumn: aBlockOrSymbol [ 
	 
	| newColumn cell | 
	cell _ aBlockOrSymbol isSymbol 
		ifTrue: 
			[self browser 
				addNewPaneNamed: aBlockOrSymbol. 
			(GLMCustomColumn new) 
				id: aBlockOrSymbol; 
				browser: self browser] 
		ifFalse: 
			[newColumn _ GLMCustomColumn new browser: self browser. 
			aBlockOrSymbol value: newColumn. 
			newColumn]. 
	self children addLast: cell. 
	^cell
]

{ #category : #accessing }
GLMCustomRow >> addColumn: aBlockOrSymbol span: anInteger [ 
	 
	^(self addColumn: aBlockOrSymbol) span: anInteger
]

{ #category : #testing }
GLMCustomRow >> isRow [ 
	 
	^true
]
