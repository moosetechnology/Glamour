Class {
	#name : #GLMSmalltalkCodePresentation,
	#superclass : #GLMTextualPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMSmalltalkCodePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSmalltalkCodePresentation: self
]
