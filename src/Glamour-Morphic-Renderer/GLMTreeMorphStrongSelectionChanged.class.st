Class {
	#name : #GLMTreeMorphStrongSelectionChanged,
	#superclass : #Announcement,
	#instVars : [
		'strongSelectionValue'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
GLMTreeMorphStrongSelectionChanged >> strongSelectionValue [
	^ strongSelectionValue
]

{ #category : #accessing }
GLMTreeMorphStrongSelectionChanged >> strongSelectionValue: anObject [
	strongSelectionValue := anObject
]
