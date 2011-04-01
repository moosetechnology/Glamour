Class {
	#name : #GLMDropDownListMorphSelectionChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectionValue'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #accessing }
GLMDropDownListMorphSelectionChanged >> selectionValue [
	^ selectionValue
]

{ #category : #accessing }
GLMDropDownListMorphSelectionChanged >> selectionValue: anObject [
	selectionValue := anObject
]
