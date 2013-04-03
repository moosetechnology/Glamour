Class {
	#name : #GLMSpecPresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMSpecPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSpecPresentation: self
]
