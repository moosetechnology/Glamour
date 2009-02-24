Class {
	#name : #GLTextPresentation,
	#superclass : #GLFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLTextPresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderTextPresentation: self
]
