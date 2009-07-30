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

{ #category : #accessing }
GLMListModel >> displayedItems [
	^self items collect: [:each | displaySelector glamourValue: each]

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
	self changed: #items; changed: #selection
	
]

{ #category : #associating }
GLMListModel >> executeReset [
	filteredItems := self canonicalItems.
	self changed: #items; changed: #selection
	
]

{ #category : #associating }
GLMListModel >> executeSearch [
	| searchResult |
	searchResult := searchBlock value: self searchText asString value: self canonicalItems.
	listSelection := searchResult asOrderedCollection.
	onSelection ifNotNil: [onSelection value: (OrderedCollection withAll: listSelection) ].
	self changed: #items; changed: #selection
	
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
	searchText := ''
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
		ifTrue: [
			(listSelection includes: anIndex)
				ifFalse: [ listSelection add: anIndex ] ]
		ifFalse: [
			listSelection
				remove: anIndex
				ifAbsent: [ ] ].
	
	onSelection ifNotNil: [onSelection value: (listSelection collect: [:eachIndex | self listAt: eachIndex])].
	self changed: #selection.
	
]

{ #category : #callbacks }
GLMListModel >> listSize [
	^self items size
]

{ #category : #callbacks }
GLMListModel >> menu: aMenuMorph [
	| actions |
	"self halt.
	dynamicMenu isNil ifTrue: [^aMenuMorph].
	actions := dynamicMenu value: (self listAt: self selection).
	actions do: [:action |
		aMenuMorph add: action title target: self selector: #executeMenuAction: argument: action].
	^aMenuMorph"
	^ MenuMorph new
		defaultTarget: self;
		add: 'Print A' action: #printA;
		balloonTextForLastItem: 'Live long and prosper!';
		addLine;
		add: 'Print B' action: #printB;
		balloonTextForLastItem: 'Search again\for the same object' withCRs;
		yourself
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #accessing }
GLMListModel >> printA [
	Transcript show: 'Print A'; cr.
	
]

{ #category : #accessing }
GLMListModel >> printB [
	Transcript show: 'Print B'; cr.
	
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
GLMListModel >> selection [ 
	^selection
]

{ #category : #callbacks }
GLMListModel >> selection: anIndex. [
	selection := anIndex. 
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
