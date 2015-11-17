"
I am a Morphic renderer for a GLMFastTablePresentation.

Description
--------------------

I use a GLMFastTableDataSource to manage the data of the table.

"
Class {
	#name : #GLMMorphicFastTableRenderer,
	#superclass : #GLMMorphicFTRenderer,
	#category : #'Glamour-FastTable-Morphic-Renderer'
}

{ #category : #initialization }
GLMMorphicFastTableRenderer >> createDataSourceFrom: aPresentation [
	^ GLMFastTableDataSource new
]

{ #category : #initialization }
GLMMorphicFastTableRenderer >> specificTableMorphInitializiation [
	| presentation |
	super specificTableMorphInitializiation.
	presentation := tableModel glamourPresentation.
	tableMorph
		columns:
			(presentation columns
				collect:
					[ :each | 
					GLMFastTableColumn new
						id: (presentation titleValueOfColumn: each);
						width: each width;
						glamourColumn: each;
						target: tableModel actionSelector: #sortByColumn: arguments: {each};
						yourself ])
]
