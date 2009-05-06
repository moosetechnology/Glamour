Class {
	#name : #GLMMagrittePresentation,
	#superclass : #GLMPresentation,
	#category : #'Glamour-Squeak'
}

{ #category : #'as yet unclassified' }
GLMMagrittePresentation >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderMagrittePresentation: self
]
