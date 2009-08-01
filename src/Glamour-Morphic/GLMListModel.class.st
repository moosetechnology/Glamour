Class {
	#name : #GLMListModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'items',
		'selection',
		'onSelection',
		'displaySelector',
		'searchText',
		'listSelection',
		'searchBlock',
		'singleSelection',
		'filterBlock',
		'filteredItems',
		'menuBlock',
		'dynamicMenu'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMListModel >> canonicalItems [
	^ items
]

{ #category : #callbacks }
GLMListModel >> displayListAt: anIndex [
	^ displaySelector glamourValue: (self items at: anIndex)
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

{ #category : #accessing }
GLMListModel >> dynamicMenu: aDynamicMenu [ 
	dynamicMenu := aDynamicMenu
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
	self flag: 'OrderedCollection should be replaced with self listSelection species'.
	searchResult := searchBlock value: self searchText asString value: self canonicalItems.
	listSelection := ((1 to: self canonicalItems size) select: [:eachIndex | searchResult includes: (self canonicalItems at: eachIndex) ]) asOrderedCollection.
	onSelection ifNotNil: [ onSelection value: listSelection ].
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
	^ self listSelection isNil not
]

{ #category : #accessing }
GLMListModel >> items [
	^ filteredItems
]

{ #category : #accessing }
GLMListModel >> items: aCollection [
	items := aCollection.
	filteredItems := aCollection.
]

{ #category : #callbacks }
GLMListModel >> listAt: anIndex [
	^ self items at: anIndex
]

{ #category : #accessing }
GLMListModel >> listSelection [
	self flag: 'check if species is correct'.
	^ listSelection ifNil: [ listSelection := self items species new asOrderedCollection]
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex [
	^ self listSelection includes: anIndex
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex put: aValue [
	aValue = true
		ifTrue: [ (self listSelection includes: anIndex) ifFalse: [ self listSelection add: anIndex ] ]
		ifFalse: [ self listSelection remove: anIndex ifAbsent: [ ] ].
	onSelection ifNotNil: [
		onSelection value: (self listSelection collect: [:eachIndex | self listAt: eachIndex])].
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> listSize [
	^self items size
]

{ #category : #callbacks }
GLMListModel >> menu: aMenuMorph [
	| actions |
	menuInvokedAction ifNotNil: [self announce: (GLMMenuInvoked action: menuInvokedAction on: aMenuMorph)].
	^aMenuMorph

	
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #accessing }
GLMListModel >> searchBlock: aBlock [
	searchBlock := aBlock
]

{ #category : #accessing }
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

{ #category : #callbacks }
GLMListModel >> selectedItems [
	self listSelection isEmpty not ifTrue: [ 
		^ self listSelection collect: [ :each | self listAt: each ] ].
	^ OrderedCollection with: (self listAt: self selection)
]

{ #category : #callbacks }
GLMListModel >> selection [ 
	^ selection
]

{ #category : #callbacks }
GLMListModel >> selection: anIndex. [
	selection := anIndex. 
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> singleSelection [ 
	^ selection
]

{ #category : #callbacks }
GLMListModel >> singleSelection: anIndex. [
	(anIndex == 0) ifFalse: [
		selection := anIndex.
		onSelection ifNotNil: [onSelection value: (self listAt: anIndex) ] ].
	self changed: #singleSelection.
]

{ #category : #updating }
GLMListModel >> updateMenu: aMenuMorph with: aCollection [
	aCollection do: [:action |
		aMenuMorph add: action title target: self selector: #executeMenuAction: argument: action ].
	^ aMenuMorph
]
