Class {
	#name : #GLMPaneRemoved,
	#superclass : #Announcement,
	#instVars : [
		'browser',
		'pane'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'instance creation' }
GLMPaneRemoved class >> pane: aPane fromBrowser: aBrowser [ 
	 
	^(self new) 
		pane: aPane; 
		browser: aBrowser; 
		yourself
]

{ #category : #accessing }
GLMPaneRemoved >> browser [ 
	 
	^browser
]

{ #category : #accessing }
GLMPaneRemoved >> browser: anObject [ 
	 
	browser := anObject
]

{ #category : #accessing }
GLMPaneRemoved >> pane [ 
	 
	^pane
]

{ #category : #accessing }
GLMPaneRemoved >> pane: anObject [ 
	 
	pane := anObject
]
