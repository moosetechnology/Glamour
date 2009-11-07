Class {
	#name : #GLMMorphPresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMMorphPresentation >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderMorphPresentation: self
]
