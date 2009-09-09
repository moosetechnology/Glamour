Class {
	#name : #GLMMultiListModel,
	#superclass : #GLMListModel,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMultiListModel >> selectItem: aCollection [
	| indexes |
	indexes := OrderedCollection new.
	self items withIndexDo: [:each :i | 
		aCollection do: [:anObject |
			each == anObject ifTrue: [indexes add: i]
		]
	].
	self selectedIndexes: indexes.
	self changed: #selection.
]
