Class {
	#name : #GLMRubricTextPresentation,
	#superclass : #GLMTextualPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricTextPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricTextPresentation: self
]
