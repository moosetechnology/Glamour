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
		'columnToSortBy',
		'stopStepping'
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

{ #category : #private }
GLMFastTableDataSource >> editRowMorphForColumn: glamourColumn element: element [
	| brick |
	
	(brick := GLMEditableLabelBrick new)
		cancelOnEscape;
		cancelOnFocusLost;
		text: (self glamourPresentation 
			column: glamourColumn
			valueFor: element);
		hSpaceFill;
		with: [ :b | b editBrick rubricBackgroundColor: b themer rubricBackgroundColor ];
		when: #onEditMode do: [ self forceStopStepping ];
		when: #onReadMode do: [ self resetStopStepping ];
		when: #onSingleClicked do: [ :event :b | b isReadMode ifTrue: [ self explicitSelection: element ] ];
		when: #onAccepted do: [ self modified: element from: glamourColumn with: brick text ];
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

{ #category : #private }
GLMFastTableDataSource >> forceStopStepping [
	stopStepping := true.
	"self changed."
]

{ #category : #factory }
GLMFastTableDataSource >> modified: anElement from: aGlamourColumn with: aText [

	aGlamourColumn modifiedBlock
		cull: aText
		cull: anElement
		cull: self glamourPresentation
]

{ #category : #private }
GLMFastTableDataSource >> resetStopStepping [
	stopStepping := false.
	"self changed."
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

{ #category : #stepping }
GLMFastTableDataSource >> shouldStopStepping [

	^ stopStepping ifNil: [ false ]
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

{ #category : #stepping }
GLMFastTableDataSource >> stepTime [
	^ self glamourPresentation stepTime
]

{ #category : #stepping }
GLMFastTableDataSource >> wantsSteps [
	^ self shouldStopStepping not and: [ self glamourPresentation wantsSteps ]
]
