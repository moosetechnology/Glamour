"
This presentation offers a means to embed a Morph. It makes sense only for the Morph Renderer.
"
Class {
	#name : #GLMMorphPresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMMorphPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderMorphPresentation: self
]
