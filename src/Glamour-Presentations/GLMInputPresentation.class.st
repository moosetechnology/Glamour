"
A GLMInputPresentation should display an simple input text.

Right now this functionality is not supported by the morphic renderer.

"
Class {
	#name : #GLMInputPresentation,
	#superclass : #GLMTextualPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMInputPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderInputPresentation: self
]
