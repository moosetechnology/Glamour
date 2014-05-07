"
I am event indicating to the renderer to execute the currently selected text and perform an action with the result.
"
Class {
	#name : #GLMEvaluateSelection,
	#superclass : #Announcement,
	#instVars : [
		'action'
	],
	#category : #'Glamour-Morphic-Renderer-Announcements'
}

{ #category : #accessing }
GLMEvaluateSelection >> action [
	^ action
]

{ #category : #accessing }
GLMEvaluateSelection >> action: anObject [
	action := anObject
]
