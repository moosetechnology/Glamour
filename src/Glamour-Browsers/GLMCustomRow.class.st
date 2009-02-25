Class {
	#name : #GLMCustomRow,
	#superclass : #GLMCustomCell,
	#category : #'Glamour-Browsers'
}

{ #category : #accessing }
GLMCustomRow >> addColumn: aBlockOrSymbol [ 
	 
	| newColumn cell | 
	cell := aBlockOrSymbol isSymbol 
		ifTrue: 
			[self browser 
				addPane: 
					((GLMPane new) 
						name: aBlockOrSymbol; 
						yourself). 
			(GLMCustomColumn new) 
				id: aBlockOrSymbol; 
				browser: self browser] 
		ifFalse: 
			[newColumn := GLMCustomColumn new browser: self browser. 
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
