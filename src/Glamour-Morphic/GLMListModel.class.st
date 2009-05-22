Class {
	#name : #GLMListModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'items',
		'selection',
		'onSelection',
		'displaySelector',
		'menuActions',
		'searchText',
		'listSelection',
		'searchBlock'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMListModel >> addMenuAction: anAction [
	menuActions add: anAction
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
	| searchResult |
	searchResult := searchBlock value: self searchText asString value: self items.
	listSelection := searchResult asOrderedCollection.
	self changed: #selection.
]

{ #category : #callbacks }
GLMListModel >> executeMenuAction: anAction [
	self announce: (GLMMenuItemSelected action: anAction)
]

{ #category : #initialization }
GLMListModel >> initialize [
	super initialize.
	selection := 0.
	menuActions := OrderedCollection new.
	listSelection := OrderedCollection new.
	searchBlock := [:text :list | OrderedCollection new]
]

{ #category : #accessing }
GLMListModel >> items [
	^items
]

{ #category : #accessing }
GLMListModel >> items: aCollection [
	items := aCollection
]

{ #category : #callbacks }
GLMListModel >> listAt: anIndex [
	^(self items at: anIndex) "perform: displaySelector"
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex [
	^listSelection includes: (items at: anIndex ifAbsent: [ ^ false ]).
]

{ #category : #callbacks }
GLMListModel >> listSelectionAt: anIndex put: aValue [

	aValue = true
		ifTrue: [listSelection add: anIndex]
		ifFalse: [listSelection
				remove: anIndex
				ifAbsent: []].
	self changed: #selection.
	
]

{ #category : #callbacks }
GLMListModel >> listSize [
	^self items size
]

{ #category : #callbacks }
GLMListModel >> menu: aMenuMorph [
	menuActions do: [:action |
		aMenuMorph add: action title target: self selector: #executeMenuAction: argument: action].
	^aMenuMorph
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

{ #category : #accessing }
GLMListModel >> stringItems [
	^items collect: [:each | displaySelector glamourValue: each]
]
