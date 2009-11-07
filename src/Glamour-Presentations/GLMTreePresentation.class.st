Class {
	#name : #GLMTreePresentation,
	#superclass : #GLMListingPresentation,
	#instVars : [
		'children'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTreePresentation >> children [ 
	 
	^children
]

{ #category : #accessing }
GLMTreePresentation >> children: anObject [ 
	 
	children := anObject
]

{ #category : #rendering }
GLMTreePresentation >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderTreePresentation: self
]
