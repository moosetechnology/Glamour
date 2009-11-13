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

{ #category : #accessing }
GLMTreePresentation >> childrenValueOf: anObject [
	^ self children glamourValue: (anObject asGlamorousMultiValue, self entity asGlamorousMultiValue)
]

{ #category : #rendering }
GLMTreePresentation >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderTreePresentation: self
]
