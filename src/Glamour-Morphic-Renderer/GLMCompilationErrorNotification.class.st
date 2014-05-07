Class {
	#name : #GLMCompilationErrorNotification,
	#superclass : #Announcement,
	#instVars : [
		'errorMessage',
		'errorLocation',
		'errorSource'
	],
	#category : #'Glamour-Morphic-Renderer-Announcements'
}

{ #category : #accessing }
GLMCompilationErrorNotification >> errorLocation [
	^ errorLocation
]

{ #category : #accessing }
GLMCompilationErrorNotification >> errorLocation: anObject [
	errorLocation := anObject
]

{ #category : #accessing }
GLMCompilationErrorNotification >> errorMessage [
	^ errorMessage
]

{ #category : #accessing }
GLMCompilationErrorNotification >> errorMessage: anObject [
	errorMessage := anObject
]

{ #category : #accessing }
GLMCompilationErrorNotification >> errorSource [
	^ errorSource
]

{ #category : #accessing }
GLMCompilationErrorNotification >> errorSource: anObject [
	errorSource := anObject
]
