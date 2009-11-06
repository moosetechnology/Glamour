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

{ #category : #'as yet unclassified' }
GLMTreePresentation >> selectionPath [
	 
	^(self pane port: #selectionPath) value
]

{ #category : #'as yet unclassified' }
GLMTreePresentation >> selectionPath: anObject [ 
	 
	(self pane port: #selectionPath) value: anObject "(self postTransformation glamourValue: anObject)"
]
