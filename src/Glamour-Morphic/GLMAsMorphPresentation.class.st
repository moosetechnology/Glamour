Class {
	#name : #GLMAsMorphPresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMAsMorphPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderAsMorphPresentation: self
]
