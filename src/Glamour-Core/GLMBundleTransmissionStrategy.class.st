Class {
	#name : #GLMBundleTransmissionStrategy,
	#superclass : #GLMTransmissionStrategy,
	#instVars : [
		'presentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMBundleTransmissionStrategy >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #'accessing-convenience' }
GLMBundleTransmissionStrategy >> addPresentations: aCollection [
	aCollection do: [:each | self addPresentation: each ]
]

{ #category : #'initialize-release' }
GLMBundleTransmissionStrategy >> initialize [
	presentations := GLMCompositePresentation new
]

{ #category : #accessing }
GLMBundleTransmissionStrategy >> presentations [
	^ presentations
]

{ #category : #accessing }
GLMBundleTransmissionStrategy >> presentations: anObject [
	presentations := anObject
]

{ #category : #transmitting }
GLMBundleTransmissionStrategy >> transmitIn: aContext [
	"it is important for the destination to be set after the presentation, 
	because when the presentation is a browser, we might forward the entity internally"
	self transmission destination hasPane ifTrue: [
		self transmission destination pane clearIn: aContext.
		self transmission destination pane presentations: self presentations copy ].

]
