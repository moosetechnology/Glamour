Class {
	#name : #GLMCompositePresentation,
	#superclass : #GLMPresentation,
	#instVars : [
		'presentations'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMCompositePresentation >> presentations [
	^ presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #accessing }
GLMCompositePresentation >> presentations: anObject [
	presentations := anObject
]

{ #category : #rendering }
GLMCompositePresentation >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderCompositePresentation: self
]
