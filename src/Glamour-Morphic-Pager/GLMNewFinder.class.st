Class {
	#name : #GLMNewFinder,
	#superclass : #GLMFinder,
	#category : #'GLM-NewFinder-Glamour'
}

{ #category : #'as yet unclassified' }
GLMNewFinder >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderNewFinder: self
]
