Class {
	#name : #GLMTreePresentation,
	#superclass : #GLMFormatedPresentation,
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
	 
	children _ anObject
]

{ #category : #rendering }
GLMTreePresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderTreePresentation: self
]
