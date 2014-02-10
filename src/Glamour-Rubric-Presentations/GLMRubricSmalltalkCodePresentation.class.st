Class {
	#name : #GLMRubricSmalltalkCodePresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricSmalltalkCodePresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricSmalltalkCodePresentation: self
]
