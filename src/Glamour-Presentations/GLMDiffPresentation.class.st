Class {
	#name : #GLMDiffPresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMDiffPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderDiffPresentation: self
]
