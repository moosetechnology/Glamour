Class {
	#name : #GLMListModel,
	#superclass : #Object,
	#instVars : [
		'items',
		'selection'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMListModel >> initialize [
	selection := 0
]

{ #category : #'as yet unclassified' }
GLMListModel >> items [
	^items
]

{ #category : #'as yet unclassified' }
GLMListModel >> items: aCollection [
	items := aCollection
]

{ #category : #'as yet unclassified' }
GLMListModel >> selection [
	^selection
]

{ #category : #'as yet unclassified' }
GLMListModel >> selection: anIndex [
	selection := anIndex
]
