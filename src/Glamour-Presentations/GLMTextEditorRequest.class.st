"
I indicate to the renderer to execute a message on the text editor morph that contains the actual text.
"
Class {
	#name : #GLMTextEditorRequest,
	#superclass : #Announcement,
	#instVars : [
		'selector'
	],
	#category : #'Glamour-Presentations-Announcements'
}

{ #category : #'instance creation' }
GLMTextEditorRequest class >> for: aSelector [

	^ self new selector: aSelector
]

{ #category : #accessing }
GLMTextEditorRequest >> selector [
	^ selector
]

{ #category : #accessing }
GLMTextEditorRequest >> selector: anObject [
	selector := anObject
]
