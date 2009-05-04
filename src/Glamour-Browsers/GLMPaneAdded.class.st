Class {
	#name : #GLMPaneAdded,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'browser',
		'position'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #'instance creation' }
GLMPaneAdded class >> pane: aPane atPosition: anInteger inBrowser: aBrowser [ 
	 
	^(self new) 
		pane: aPane; 
		position: anInteger; 
		browser: aBrowser; 
		yourself
]

{ #category : #accessing }
GLMPaneAdded >> browser [ 
	 
	^browser
]

{ #category : #accessing }
GLMPaneAdded >> browser: anObject [ 
	 
	browser _ anObject
]

{ #category : #accessing }
GLMPaneAdded >> pane [ 
	 
	^pane
]

{ #category : #accessing }
GLMPaneAdded >> pane: anObject [ 
	 
	pane _ anObject
]

{ #category : #accessing }
GLMPaneAdded >> position [ 
	 
	^position
]

{ #category : #accessing }
GLMPaneAdded >> position: anObject [ 
	 
	position _ anObject
]
