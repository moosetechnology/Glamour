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
	self flag: 'This hierarchy should probably go away'.
	^ presentationContext
]

{ #category : #accessing }
GLMPresentationBuilder >> presentationContext: anObject [
	presentationContext := anObject
]
