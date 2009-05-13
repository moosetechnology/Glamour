Class {
	#name : #GLMMagrittePresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMagrittePresentation >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderMagrittePresentation: self
]
