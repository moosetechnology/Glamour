Class {
	#name : #GLMMorphTreeColumn,
	#superclass : #MorphTreeColumn,
	#instVars : [
		'glamourColumn'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphTreeColumn >> glamourColumn: aColumn [
	glamourColumn := aColumn
]

{ #category : #'as yet unclassified' }
GLMMorphTreeColumn >> rowMorphFor: aNodeMorph [
	^ aNodeMorph rowMorphForColumn: glamourColumn.
]
