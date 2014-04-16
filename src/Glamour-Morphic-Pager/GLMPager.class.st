Class {
	#name : #GLMPager,
	#superclass : #GLMFinder,
	#category : #'Glamour-Morphic-Pager-Glamour'
}

{ #category : #'as yet unclassified' }
GLMPager >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderPager: self
]
