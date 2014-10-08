Class {
	#name : #GLMPaginatedResizableMorphTreeMorph,
	#superclass : #PaginatedMorphTreeMorph,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'as yet unclassified' }
GLMPaginatedResizableMorphTreeMorph >> resizeColumns [
	| rowMorphsWidths |
	
	self columns size > 1 ifFalse: [^ self].
		rowMorphsWidths := self rowMorphsWidths.
		self allNodeMorphs do: [ :node |
			node submorphs
				inject: 1
				into: [ :index :morph |
					morph width: (rowMorphsWidths at: index).
					index + 1
				]
		].

		self hHideScrollBar.
]

{ #category : #'as yet unclassified' }
GLMPaginatedResizableMorphTreeMorph >> toggleExpandedState: aMorph event: event [
	super toggleExpandedState: aMorph event: event.
	
	self resizeColumns.
]

{ #category : #'as yet unclassified' }
GLMPaginatedResizableMorphTreeMorph >> updateColumnMorphs [
	super updateColumnMorphs.
	self resizeColumns.
		
	
]
