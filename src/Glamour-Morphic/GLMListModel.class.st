Class {
	#name : #GLMListModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'items',
		'selection',
		'displaySelector',
		'searchText',
		'searchBlock',
		'singleSelection',
		'filterBlock',
		'filteredItems',
		'menuBlock',
		'dynamicMenu',
		'onSelectionBlock',
		'selectedIndexes'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMListModel >> canonicalItems [
	^ items
]

{ #category : #callbacks }
GLMListModel >> displayListAt: anIndex [
	^ self glamourPresentation formatedDisplayValueOf: (self items at: anIndex)
]

{ #category : #accessing }
GLMListModel >> displaySelector: aSymbol [
	displaySelector := aSymbol
]

{ #category : #accessing }
GLMListModel >> displayedItems [
	^ self items collect: [:each | displaySelector glamourValue: each]

]

{ #category : #associating }
GLMListModel >> doSearch [
	searchText isEmptyOrNil
		ifTrue: [ self executeReset ]
		ifFalse:[ 
			searchBlock isNil 
				ifTrue: [ self executeFilter ]
				ifFalse: [ self executeSearch ] ].
		
	
]

{ #category : #associating }
GLMListModel >> executeFilter [
	filteredItems := filterBlock value: self searchText asString value: self canonicalItems.
	self changed: #displayedItems; changed: #selection
	
]

{ #category : #associating }
GLMListModel >> executeReset [
	filteredItems := self canonicalItems.
	self changed: #items; changed: #selection
	
]

{ #category : #associating }
GLMListModel >> executeSearch [
	| searchResult |
	searchResult := searchBlock 
		value: self searchText asString
		value: self canonicalItems.
	selectedIndexes := ((1 to: self canonicalItems size) select: [ :eachIndex | searchResult includes: (self canonicalItems at: eachIndex) ]) asOrderedCollection.
	onSelectionBlock ifNotNil: [ onSelectionBlock value: searchResult ].
	self changed: #allSelections
	"self changed: #displayedItems; changed: #selection"
]

{ #category : #accessing }
GLMListModel >> filterBlock: aBlock [
	filterBlock := aBlock
]

{ #category : #initialization }
GLMListModel >> initialize [
	super initialize.
	selection := 0.
	searchText := ''
	"searchBlock := [:text :list | OrderedCollection new]"
]

{ #category : #testing }
GLMListModel >> isMultiple [
	^ self selectedIndexes isNil not
]

{ #category : #accessing }
GLMListModel >> items [
	^ filteredItems
]

{ #category : #accessing }
GLMListModel >> items: aCollection [
	| nonSetCollection |
	nonSetCollection := (aCollection isKindOf: Set) ifTrue: [aCollection asOrderedCollection] ifFalse: [aCollection].
	items := nonSetCollection.
	filteredItems := nonSetCollection.
]

{ #category : #callbacks }
GLMListModel >> listAt: anIndex [
	^ self items at: anIndex
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex [ 
	^ self selectedIndexes includes: anIndex
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex put: aValue [ 
	aValue = true
		ifTrue: [ (self selectedIndexes includes: anIndex) ifFalse: [ self selectedIndexes add: anIndex ] ]
		ifFalse: [ self selectedIndexes remove: anIndex ifAbsent: [  ] ].
	onSelectionBlock ifNotNil: [
		onSelectionBlock value: self selectedItems ].
	self changed: #selection
]

{ #category : #callbacks }
GLMListModel >> listSize [
	^self items size
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [ 
	onSelectionBlock := aBlock
]

{ #category : #accessing }
GLMListModel >> searchBlock: aBlock [
	searchBlock := aBlock
]

{ #category : #callbacks }
GLMListModel >> searchEnabled [
	^ true
]

{ #category : #accessing }
GLMListModel >> searchText [
	^ searchText
]

{ #category : #accessing }
GLMListModel >> searchText: aString [
	searchText := aString.
	self doSearch

]

{ #category : #accessing }
GLMListModel >> selectedIndexes [
	"this only holds the indexes of the selected items in terms of the entire collection of items"
	^ selectedIndexes ifNil: [ selectedIndexes := OrderedCollection new ]
]

{ #category : #accessing }
GLMListModel >> selectedItems [
	"This holds the collection of the actual selected items. It must be in sync with the selectedIndexes"
	^  self items species withAll: (self selectedIndexes collect: [ :eachIndex | self listAt: eachIndex ])
]

{ #category : #callbacks }
GLMListModel >> selection [ 
	^ selection
]

{ #category : #callbacks }
GLMListModel >> selection: anIndex [
	selection := anIndex. 
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> singleSelection [ 
	^ selection
]

{ #category : #callbacks }
GLMListModel >> singleSelection: anIndex [ 
	self flag: 'What is the difference between singleSelection and selection?'.
	anIndex == 0 ifFalse: 
		[ selection := anIndex.
		onSelectionBlock ifNotNil: [ onSelectionBlock value: (self listAt: anIndex) ] ].
	self changed: #singleSelection
]
