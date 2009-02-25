Class {
	#name : #GLMTextPresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMTextPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderTextPresentation: self
]
