Class {
	#name : #GLMWorkspacePresentation,
	#superclass : #GLMFormatedPresentation,
	#category : #'Glamour-Presentations'
}

{ #category : #rendering }
GLMWorkspacePresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderWorkspacePresentation: self
]
