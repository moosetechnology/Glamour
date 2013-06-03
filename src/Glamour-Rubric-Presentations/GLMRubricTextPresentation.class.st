Class {
	#name : #GLMRubricTextPresentation,
	#superclass : #GLMTextualPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #'as yet unclassified' }
GLMRubricTextPresentation >> renderGlamorouslyOn: aRenderer [
	self registerAnnouncements.
	^ aRenderer renderRubricTextPresentation: self
]
