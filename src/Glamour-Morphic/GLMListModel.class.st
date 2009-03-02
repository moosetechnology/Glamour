Class {
	#name : #GLMListModel,
	#superclass : #Object,
	#instVars : [
		'items',
		'selection',
		'onSelection',
		'displaySelector'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMListModel >> displaySelector: aSymbol [
	displaySelector := aSymbol
]

{ #category : #accessing }
GLMListModel >> initialize [
	selection := 0
]

{ #category : #accessing }
GLMListModel >> items [
	^items
]

{ #category : #accessing }
GLMListModel >> items: aCollection [
	items := aCollection
]

{ #category : #accessing }
GLMListModel >> listAt: anIndex [
	^(self items at: anIndex) "perform: displaySelector"
]

{ #category : #accessing }
GLMListModel >> listSize [
	^self items size
]

{ #category : #updating }
GLMListModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #accessing }
GLMListModel >> selection [ 
	^selection
]

{ #category : #accessing }
GLMListModel >> selection: anIndex. [
	selection := anIndex.
	onSelection ifNotNil: [onSelection value: (self listAt: anIndex)].
	self changed: #selection.
]
