Class {
	#name : #GLMNewFinder,
	#superclass : #GLMFinder,
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #'as yet unclassified' }
GLMNewFinder >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderNewFinder: self
]
