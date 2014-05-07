"
I am event indicating to the renderer to update its variable bindings.
"
Class {
	#name : #GLMVariableBindingsChanged,
	#superclass : #Announcement,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Morphic-Renderer-Announcements'
}

{ #category : #accessing }
GLMVariableBindingsChanged >> presentation [
	^ presentation
]

{ #category : #accessing }
GLMVariableBindingsChanged >> presentation: anObject [
	presentation := anObject
]
