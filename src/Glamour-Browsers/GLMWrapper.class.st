Class {
	#name : #GLMWrapper,
	#superclass : #GLMImplicitBrowser,
	#category : #'Glamour-Browsers'
}

{ #category : #rendering }
GLMWrapper >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderFinder: self
]
