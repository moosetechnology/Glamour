Class {
	#name : #GLTreePresentation,
	#superclass : #GLFormatedPresentation,
	#instVars : [
		'children'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLTreePresentation >> children [
	
	^children
]

{ #category : #accessing }
GLTreePresentation >> children: anObject [
	
	children := anObject
]

{ #category : #rendering }
GLTreePresentation >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderTreePresentation: self
]
