Class {
	#name : #GLMatchingPresentationsChanged,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'oldMatchingPresentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMatchingPresentationsChanged >> matchingPresentations [
	"The presentations that match now."
	
	^self pane matchingPresentations
]

{ #category : #accessing }
GLMatchingPresentationsChanged >> oldMatchingPresentations [
	"The presentations that matched before this announcement."
	
	^oldMatchingPresentations
]

{ #category : #accessing }
GLMatchingPresentationsChanged >> oldMatchingPresentations: aCollection [
	"The presentations that matched before this announcement."
	
	oldMatchingPresentations := aCollection
]

{ #category : #accessing }
GLMatchingPresentationsChanged >> pane [
	"The pane on which the matching presentations changed."
	
	^pane
]

{ #category : #accessing }
GLMatchingPresentationsChanged >> pane: aPane [
	"The pane on which the matching presentations changed."
	
	pane := aPane
]
