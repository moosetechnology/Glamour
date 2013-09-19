Class {
	#name : #GLMRubricSmalltalkCodePresentation,
	#superclass : #GLMSmalltalkCodePresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricSmalltalkCodePresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricSmalltalkCodePresentation: self
]
