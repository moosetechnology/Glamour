"
GLMDiffPresentation is meant to show the difference between two input text objects.

The convention is that the transformed entity should provide a collection with two elements.
"
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
