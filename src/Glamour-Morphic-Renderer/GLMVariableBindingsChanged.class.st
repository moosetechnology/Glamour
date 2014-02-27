Class {
	#name : #GLMVariableBindingsChanged,
	#superclass : #Announcement,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
GLMVariableBindingsChanged >> presentation [
	^ presentation
]

{ #category : #accessing }
GLMVariableBindingsChanged >> presentation: anObject [
	presentation := anObject
]
