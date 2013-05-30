"
The abstract strategy that deals with setting of presentations on the pane of the destination port.
"
Class {
	#name : #GLMPresentStrategy,
	#superclass : #GLMTransmissionStrategy,
	#instVars : [
		'presentationsFactory'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMPresentStrategy >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #'accessing-convenience' }
GLMPresentStrategy >> addPresentations: aCollection [
	aCollection do: [:each | self addPresentation: each ]
]

{ #category : #accessing }
GLMPresentStrategy >> presentations [
	| presentations |
	presentations := GLMCompositePresentation new.
	self presentationsFactory glamourValue: (
			presentations asGlamorousMultiValue, 
			(self transmission origins collect: #value )).
	^ presentations
]

{ #category : #accessing }
GLMPresentStrategy >> presentations: anObject [
	presentations := anObject
]

{ #category : #accessing }
GLMPresentStrategy >> presentationsFactory [
	^ presentationsFactory
]

{ #category : #accessing }
GLMPresentStrategy >> presentationsFactory: anObject [
	presentationsFactory := anObject
]
