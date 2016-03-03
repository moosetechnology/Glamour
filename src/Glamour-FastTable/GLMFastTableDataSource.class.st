"
I'm a model datasource to handle glamour fast table presentations.

Description 
--------------------

I am a GLMFastListDataSource that can also manage multi columns.

I work with a GLMFastTablePresentation and a GLMMorphicFastTableRenderer. 

"
Class {
	#name : #GLMFastTableDataSource,
	#superclass : #GLMFastListDataSource,
	#instVars : [
		'columnToSortBy'
	],
	#category : #'Glamour-FastTable-Model'
}

{ #category : #accessing }
GLMFastTableDataSource >> cellColumn: column row: rowIndex [ 
	| element cell |
	
	element := self elementAt: rowIndex.
	cell := FTCellMorph new
		cellInset: 5;
		addMorph: (self 
			rowMorphForColumn: column glamourColumn 
			element: element);
		yourself.

	(self table columns first == column) ifTrue: [
		| icon |
		icon := self glamourPresentation icon cull: element.
		icon ifNotNil: [ cell addMorph: icon asMorph ] ].

	^ cell
]

{ #category : #factory }
GLMFastTableDataSource >> editRowMorphForColumn: glamourColumn element: element [
	| brick |
	
	(brick := GLMEditableLabelBrick new)
		cancelOnEscape;
		cancelOnFocusLost;
		text: (self valueFor: glamourColumn);
		hSpaceFill;
		with: [ :b | b editBrick rubricBackgroundColor: b themer rubricBackgroundColor ];
		"when: #onEditMode do: [ self containerTree forceStopStepping ];
		when: #onReadMode do: [ self containerTree resetStopStepping ];"
		"when: #onSingleClicked do: [ :event :b | b isReadMode ifTrue: [ self selectItem ] ];"
		"when: #onAccepted do: [ self modified: glamourColumn with: brick text ];"
		yourself.
			
	^ brick asMorph
		hSpaceFill;
		vShrinkWrap
]

{ #category : #private }
GLMFastTableDataSource >> elementsSorted [
	elements ifNil: [ ^ nil ].
	^ columnToSortBy 
		ifNotNil: [ elements sorted: self sortBlock ]
		ifNil: [ self calculateElements ]
]

{ #category : #factory }
GLMFastTableDataSource >> rowMorphForColumn: glamourColumn element: element [
	| rowElements contentMorph tagMorphs |
		
	contentMorph := glamourColumn modifiedBlock
		ifNotNil: [ self editRowMorphForColumn: glamourColumn element: element ]
		ifNil: [ self viewRowMorphForColumn: glamourColumn element: element ].
	
	tagMorphs := self tagMorphsFrom: glamourColumn for: element.
	tagMorphs ifEmpty: [ ^ contentMorph ].
	
	rowElements := OrderedCollection new
		add: contentMorph;
		addAll: tagMorphs;
		yourself.
	
	^ (UITheme current newRowIn: World for: rowElements)	
]

{ #category : #private }
GLMFastTableDataSource >> sortBlock [
	^ columnToSortBy sortBlock ifNil: [ 
		columnToSortBy defaultSortBlockForPresentation: self glamourPresentation ]
]

{ #category : #accessing }
GLMFastTableDataSource >> sortByColumn: aGlamourColumn [
	columnToSortBy := (columnToSortBy == aGlamourColumn 
		ifTrue: [ nil ]
		ifFalse: [ aGlamourColumn ]).
	elements := self elementsSorted.
	self glamourPresentation changed.
]
