Class {
	#name : #GLMMatchingPresentationsChanged,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'oldMatchingPresentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMMatchingPresentationsChanged >> matchingPresentations [ 
	"The presentations that match now." 
	 
	^self pane matchingPresentations
]

{ #category : #accessing }
GLMMatchingPresentationsChanged >> oldMatchingPresentations [ 
	"The presentations that matched before this announcement." 
	 
	^oldMatchingPresentations
]

{ #category : #accessing }
GLMMatchingPresentationsChanged >> oldMatchingPresentations: aCollection [ 
	"The presentations that matched before this announcement." 
	 
	oldMatchingPresentations _ aCollection
]

{ #category : #accessing }
GLMMatchingPresentationsChanged >> pane [ 
	"The pane on which the matching presentations changed." 
	 
	^pane
]

{ #category : #accessing }
GLMMatchingPresentationsChanged >> pane: aPane [ 
	"The pane on which the matching presentations changed." 
	 
	pane _ aPane
]
