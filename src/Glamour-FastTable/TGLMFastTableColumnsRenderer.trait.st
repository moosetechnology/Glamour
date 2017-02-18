"
I am a Trait that provides methods for creating rows in a Glamour presentation with columns. I exist mainly ro provides code reuse. 

Description 
--------------------

My main entry point is #cellColumn:row:. This is the method called by FTTableMorph on a data source for obtaining the rows to display.  I can configure rows to also be editable.


Internal Representation and Key Implementation Points.
--------------------

- #rowMorphElementsForFirstColumn:item:in:    I am a  hook method for configuring the first column (tables and tree need a different first column)
- #dataFromPresentationItem:                                     I am a hook methods for getting the actual data from an item of the FTTableMorph
"
Trait {
	#name : #TGLMFastTableColumnsRenderer,
	#category : #'Glamour-FastTable-Model'
}

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> cellColumn: aColumn row: aRowIndex [
	| item cell |
	item := self elementAt: aRowIndex.
	cell := FTCellMorph new
		cellInset: 5;
		addMorph: (self 
			rowMorphForColumn: aColumn 
			item: item 
			withIndex: aRowIndex);
		yourself.
	^ cell
]

{ #category : #accessing }
TGLMFastTableColumnsRenderer >> dataFromPresentationItem: anItem [
	self explicitRequirement
]

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> editRowMorphForColumn: glamourColumn element: element withIndex: aRowIndex [ 
	| brick |
	
	(brick := GLMEditableLabelBrick new)
		cancelOnEscape;
		cancelOnFocusLost;
		text: (self valueFor: element in: glamourColumn);
		hSpaceFill;
		with: [ :b | b editBrick rubricBackgroundColor: b themer rubricBackgroundColor ];
		when: #onSingleClicked do: [ :event :b | b isReadMode ifTrue: [ self table selectRowIndex: aRowIndex ] ];
		when: #onAccepted do: [ 
			glamourColumn modifiedBlock
				cull: brick text
				cull: element
				cull: self glamourPresentation ];
		yourself.
			
	^ brick asMorph
		hSpaceFill;
		vShrinkWrap
]

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> rowMorphElementsForColumn: glamourColumn element: element withIndex: aRowIndex [ 
	| rowElements contentMorph tagMorphs |
		
	contentMorph := glamourColumn modifiedBlock
		ifNotNil: [ self editRowMorphForColumn: glamourColumn element: element withIndex: aRowIndex ]
		ifNil: [ self viewRowMorphForColumn: glamourColumn element: element withIndex: aRowIndex ].
	
	rowElements := OrderedCollection new
		add: contentMorph;
		yourself.
	
	tagMorphs := self tagMorphsFrom: glamourColumn for: element.
	tagMorphs ifNotEmpty: [
		rowElements addAll: tagMorphs ].
	
	^ rowElements
]

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> rowMorphElementsForFirstColumn: aColumn item: anItem in: rowElements [
	self explicitRequirement  
]

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> rowMorphForColumn: aColumn item: anItem withIndex: aRowIndex [
	| rowElements |
	rowElements := OrderedCollection new.
	
	(self table columns first == aColumn) ifTrue: [
		self rowMorphElementsForFirstColumn: aColumn item: anItem in: rowElements ].
	
	rowElements
		addAll: (self 
			rowMorphElementsForColumn: aColumn glamourColumn 
			element: (self dataFromPresentationItem: anItem)
			withIndex: aRowIndex ).
		
	^ Smalltalk ui theme newRowIn: World for: rowElements
]

{ #category : #accessing }
TGLMFastTableColumnsRenderer >> valueFor: anElement in: aGlamourColumn [

	^ self glamourPresentation column: aGlamourColumn valueFor: anElement
]

{ #category : #rendering }
TGLMFastTableColumnsRenderer >> viewRowMorphForColumn: aGlamourColumn element: anElement withIndex: anInteger [
	^ (self 
		valueFor: (self glamourPresentation isWithElementIndex
			ifTrue: [ 
				anElement asGlamorousMultiValue,
				anInteger asGlamorousMultiValue ]
			ifFalse: [ anElement ])
		in: aGlamourColumn) asMorph asReadOnlyMorph
]