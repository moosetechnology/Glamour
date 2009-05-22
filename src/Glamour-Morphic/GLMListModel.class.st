Class {
	#name : #GLMListModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'items',
		'selection',
		'onSelection',
		'displaySelector',
		'searchText'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #callbacks }
GLMListModel >> displayListAt: anIndex [
	^displaySelector glamourValue: (self items at: anIndex)
]

{ #category : #accessing }
GLMListModel >> displaySelector: aSymbol [
	displaySelector := aSymbol
]

{ #category : #initialization }
GLMListModel >> initialize [
	super initialize.
	selection := 0.
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
GLMListModel >> listSize [
	^self items size
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [
	onSelection := aBlock
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
	self halt.
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
	selection := anIndex. 
	onSelection ifNotNil: [onSelection value: (self listAt: anIndex)].
	self changed: #selection.
]

{ #category : #accessing }
GLMListModel >> stringItems [
	^items collect: [:each | displaySelector glamourValue: each]
]
