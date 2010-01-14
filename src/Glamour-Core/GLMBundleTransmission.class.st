"
The main transmission kind.

Instance Variables:
	destination	<BoundPort>	description of destination
	origins	<OrderedCollection>	description of origins
	presentations	<OrderedCollection>	description of presentations


"
Class {
	#name : #GLMBundleTransmission,
	#superclass : #GLMTransmission,
	#instVars : [
		'presentations'
	],
	#category : #'Glamour-Core'
}

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentation: aPresentation [
	self strategyBeforeValue presentations add: aPresentation
]

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentations: aCollection [
	aCollection do: [:each | self addPresentation: each]
]

{ #category : #'initialize-release' }
GLMBundleTransmission >> initialize [
	super initialize.
	strategyBeforeValue := GLMTransmissionBundleStrategy of: self.

]

{ #category : #accessing }
GLMBundleTransmission >> presentations [ 
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]

{ #category : #transmitting }
GLMBundleTransmission >> transmitIn: aContext [
	self strategyBeforeValue transmitIn: aContext.
	"it is important for the destination to be set after the presentation, 
	because when the presentation is a browser, we might forward the entity internally"
	self destination receive: self in: aContext.
]
