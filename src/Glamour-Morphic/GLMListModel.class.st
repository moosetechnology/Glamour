Class {
	#name : #GLMListModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'items',
		'selection',
		'onSelection',
		'displaySelector',
		'menuActions'
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

{ #category : #callbacks }
GLMListModel >> executeMenuAction: anAction [
	self announce: (GLMMenuItemSelected action: anAction)
]

{ #category : #initialization }
GLMListModel >> initialize [
	super initialize.
	selection := 0.
	menuActions := OrderedCollection new.
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
