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
