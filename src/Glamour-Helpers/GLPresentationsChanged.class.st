Class {
	#name : #GLPresentationsChanged,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'oldPresentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLPresentationsChanged >> oldPresentations [
	"The presentations that were present on the pane before the change."
	
	^oldPresentations
]

{ #category : #accessing }
GLPresentationsChanged >> oldPresentations: aCollection [
	"The presentations that were present on the pane before the change."
	
	oldPresentations := aCollection
]

{ #category : #accessing }
GLPresentationsChanged >> pane [
	"The pane on which the presentations changed."
	
	^pane
]

{ #category : #accessing }
GLPresentationsChanged >> pane: aPane [
	"The pane on which the presentations changed."
	
	pane := aPane
]

{ #category : #'accessing-convenience' }
GLPresentationsChanged >> presentations [
	"The presentationt that are currently present on the pane."
	
	^self pane presentations
]
