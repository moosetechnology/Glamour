"
I extend the simple Rubric text presentation with for single line text editing

"
Class {
	#name : #GLMRubricTextFieldPresentation,
	#superclass : #GLMRubricTextPresentation,
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #rendering }
GLMRubricTextFieldPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderRubricTextFieldPresentation: self.
]
