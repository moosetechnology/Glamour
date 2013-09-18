Class {
	#name : #GLMRubricSmalltlakCodePresentation,
	#superclass : #GLMSmalltalkCodePresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricSmalltlakCodePresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricSmalltalkCodePresentation: self
]
