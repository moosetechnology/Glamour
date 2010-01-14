Class {
	#name : #GLMTransmissionBundleStrategy,
	#superclass : #GLMTransmissionPreValueStrategy,
	#instVars : [
		'presentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMTransmissionBundleStrategy >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #'accessing-convenience' }
GLMTransmissionBundleStrategy >> addPresentations: aCollection [
	aCollection do: [:each | self addPresentation: each ]
]

{ #category : #'initialize-release' }
GLMTransmissionBundleStrategy >> initialize [
	presentations := GLMCompositePresentation new
]

{ #category : #accessing }
GLMTransmissionBundleStrategy >> presentations [
	^ presentations
]

{ #category : #accessing }
GLMTransmissionBundleStrategy >> presentations: anObject [
	presentations := anObject
]

{ #category : #transmitting }
GLMTransmissionBundleStrategy >> transmitIn: aContext [
	"it is important for the destination to be set after the presentation, 
	because when the presentation is a browser, we might forward the entity internally"
	self transmission destination hasPane ifTrue: [
		self transmission destination pane clearIn: aContext.
		self transmission destination pane presentations: self presentations copy ].

]
