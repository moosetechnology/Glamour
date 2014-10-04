Class {
	#name : #GLMPaneReplaced,
	#superclass : #GLMPaneAnnouncement,
	#instVars : [
		'oldPane',
		'newPane'
	],
	#category : #'Glamour-Browsers-Announcements'
}

{ #category : #'as yet unclassified' }
GLMPaneReplaced class >> oldPane: oldPane newPane: newPane fromBrowser: aBrowser [
	^ self new 
		oldPane: oldPane;
		newPane: newPane;
		browser: aBrowser
]

{ #category : #accessing }
GLMPaneReplaced >> newPane [
	^ newPane
]

{ #category : #accessing }
GLMPaneReplaced >> newPane: anObject [
	newPane := anObject
]

{ #category : #accessing }
GLMPaneReplaced >> oldPane [
	^ oldPane
]

{ #category : #accessing }
GLMPaneReplaced >> oldPane: anObject [
	oldPane := anObject
]
