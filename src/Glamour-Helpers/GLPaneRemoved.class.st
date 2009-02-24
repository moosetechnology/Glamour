Class {
	#name : #GLPaneRemoved,
	#superclass : #Announcement,
	#instVars : [
		'browser',
		'pane'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'instance creation' }
GLPaneRemoved class >> pane: aPane fromBrowser: aBrowser [
	
	^(self new)
		pane: aPane;
		browser: aBrowser;
		yourself
]

{ #category : #accessing }
GLPaneRemoved >> browser [
	
	^browser
]

{ #category : #accessing }
GLPaneRemoved >> browser: anObject [
	
	browser := anObject
]

{ #category : #accessing }
GLPaneRemoved >> pane [
	
	^pane
]

{ #category : #accessing }
GLPaneRemoved >> pane: anObject [
	
	pane := anObject
]
