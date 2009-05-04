Class {
	#name : #GLMPresentationsChanged,
	#superclass : #Announcement,
	#instVars : [
		'pane',
		'oldPresentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPresentationsChanged >> oldPresentations [ 
	"The presentations that were present on the pane before the change." 
	 
	^oldPresentations
]

{ #category : #accessing }
GLMPresentationsChanged >> oldPresentations: aCollection [ 
	"The presentations that were present on the pane before the change." 
	 
	oldPresentations _ aCollection
]

{ #category : #accessing }
GLMPresentationsChanged >> pane [ 
	"The pane on which the presentations changed." 
	 
	^pane
]

{ #category : #accessing }
GLMPresentationsChanged >> pane: aPane [ 
	"The pane on which the presentations changed." 
	 
	pane _ aPane
]

{ #category : #'accessing-convenience' }
GLMPresentationsChanged >> presentations [ 
	"The presentationt that are currently present on the pane." 
	 
	^self pane presentations
]
