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
		'filteredItems'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMListModel >> canonicalItems [
	^items
]

{ #category : #callbacks }
GLMListModel >> displayListAt: anIndex [
	^displaySelector glamourValue: (self items at: anIndex)
]

{ #category : #accessing }
GLMListModel >> displaySelector: aSymbol [
	displaySelector := aSymbol
]

{ #category : #associating }
GLMListModel >> doSearch [
	searchBlock isNil 
					ifTrue: [self executeFilter]
					ifFalse: [self executeSearch].
	
]

{ #category : #associating }
GLMListModel >> executeFilter [

	filteredItems := filterBlock value: self searchText asString value: self canonicalItems.
	self changed: #items
	
]

{ #category : #associating }
GLMListModel >> executeSearch [
	
	| searchResult |
	searchResult := searchBlock value: self searchText asString value: self items.
	listSelection := searchResult asOrderedCollection.
	onSelection ifNotNil: [onSelection value: (OrderedCollection withAll: listSelection) ].
	self changed: #selection.
	
]

{ #category : #accessing }
GLMListModel >> filterBlock: aBlock [

	filterBlock := aBlock
]

{ #category : #initialization }
GLMListModel >> initialize [
	super initialize.
	selection := 0.
	listSelection := OrderedCollection new.
	"searchBlock := [:text :list | OrderedCollection new]"
]

{ #category : #accessing }
GLMListModel >> items [
	^filteredItems
]

{ #category : #accessing }
GLMListModel >> items: aCollection [
	items := aCollection.
	filteredItems := aCollection.
]

{ #category : #callbacks }
GLMListModel >> listAt: anIndex [
	^(self items at: anIndex) "perform: displaySelector"
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex [
	^listSelection includes: anIndex
	"^listSelection includes: (items at: anIndex ifAbsent: [ ^ false ])."
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex put: aValue [
	aValue = true
		ifTrue: [listSelection add: anIndex]
		ifFalse: [listSelection
				remove: anIndex
				ifAbsent: []].
	
	onSelection ifNotNil: [onSelection value: (listSelection collect: [:eachIndex | self listAt: eachIndex])].
	self changed: #selection.
	
]

{ #category : #callbacks }
GLMListModel >> listSize [
	^self items size
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #associating }
GLMListModel >> search [
	^true
]

{ #category : #associating }
GLMListModel >> search: arguments [
	self halt
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
	^ searchText ifNil: [searchText := '']
]

{ #category : #accessing }
GLMListModel >> searchText: aString [
	searchText := aString.

]

{ #category : #callbacks }
GLMListModel >> selectSilently: anIndex. [
	selection := anIndex. 
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> selection [ 
	^selection
]

{ #category : #callbacks }
GLMListModel >> selection: anIndex. [
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> singleSelection [ 
	^selection
]

{ #category : #callbacks }
GLMListModel >> singleSelection: anIndex. [
	(anIndex == 0) ifFalse: [
		selection := anIndex.
		onSelection ifNotNil: [onSelection value: (self listAt: anIndex) ] ].
	self changed: #singleSelection.
]

{ #category : #accessing }
GLMListModel >> stringItems [
	^items collect: [:each | displaySelector glamourValue: each]
]
