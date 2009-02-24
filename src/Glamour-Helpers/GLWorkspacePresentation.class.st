Class {
	#name : #GLWorkspacePresentation,
	#superclass : #GLFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLWorkspacePresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderWorkspacePresentation: self
]
