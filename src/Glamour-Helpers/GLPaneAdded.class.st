Class {
	#name : #GLPaneAdded,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'browser',
		'position'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'instance creation' }
GLPaneAdded class >> pane: aPane atPosition: anInteger inBrowser: aBrowser [
	
	^(self new)
		pane: aPane;
		position: anInteger;
		browser: aBrowser;
		yourself
]

{ #category : #accessing }
GLPaneAdded >> browser [
	
	^browser
]

{ #category : #accessing }
GLPaneAdded >> browser: anObject [
	
	browser := anObject
]

{ #category : #accessing }
GLPaneAdded >> pane [
	
	^pane
]

{ #category : #accessing }
GLPaneAdded >> pane: anObject [
	
	pane := anObject
]

{ #category : #accessing }
GLPaneAdded >> position [
	
	^position
]

{ #category : #accessing }
GLPaneAdded >> position: anObject [
	
	position := anObject
]
