"
The abstract strategy that deals with setting of presentations on the pane of the destination port.
"
Class {
	#name : #GLMPresentStrategy,
	#superclass : #GLMTransmissionStrategy,
	#instVars : [
		'presentations'
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

{ #category : #'initialize-release' }
GLMPresentStrategy >> initialize [
	presentations := GLMCompositePresentation new
]

{ #category : #accessing }
GLMPresentStrategy >> presentations [
	^ presentations
]

{ #category : #accessing }
GLMPresentStrategy >> presentations: anObject [
	presentations := anObject
]
