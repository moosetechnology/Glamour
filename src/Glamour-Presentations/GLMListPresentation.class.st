Class {
	#name : #GLMListPresentation,
	#superclass : #GLMListingPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMListPresentation >> renderGlamorouslyOn: aRenderer [ 
	^aRenderer renderListPresentation: self
]
