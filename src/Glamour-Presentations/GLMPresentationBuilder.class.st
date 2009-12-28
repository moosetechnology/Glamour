Class {
	#name : #GLMPresentationBuilder,
	#superclass : #Object,
	#instVars : [
		'presentationContext'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMPresentationBuilder >> presentationContext [
	^ presentationContext
]

{ #category : #accessing }
GLMPresentationBuilder >> presentationContext: anObject [
	presentationContext := anObject
]
