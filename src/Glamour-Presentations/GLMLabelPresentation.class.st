Class {
	#name : #GLMLabelPresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMLabelPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderLabelPresentation: self
]
