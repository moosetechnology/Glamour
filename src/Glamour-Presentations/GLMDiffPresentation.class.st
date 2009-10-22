Class {
	#name : #GLMDiffPresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMDiffPresentation >> renderGlamorouslyOn: aRenderer [ 
	^aRenderer renderDiffPresentation: self
]
