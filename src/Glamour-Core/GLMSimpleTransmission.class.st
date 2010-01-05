"
A GLMSimpleTransmission connects one origin port with one destination port. Whenever the origin changes, the value is passed to the destination.
"
Class {
	#name : #GLMSimpleTransmission,
	#superclass : #GLMTransmission,
	#instVars : [
		'origin'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMSimpleTransmission >> addActiveOrigin: aPort [
	self origin: aPort
]

{ #category : #copying }
GLMSimpleTransmission >> changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser [
	super changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser.
	self origin: (self origin copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser).

]

{ #category : #accessing }
GLMSimpleTransmission >> origin [ 
	 
	^origin
]

{ #category : #accessing }
GLMSimpleTransmission >> origin: aPort [ 
	 
	origin := aPort
]

{ #category : #testing }
GLMSimpleTransmission >> originatesAt: aPort [ 
	 
	^self origin = aPort
]

{ #category : #accessing }
GLMSimpleTransmission >> origins [
	"this is a hack used in Browser>>postCopy to make it polymorphic with BundleTransmission"
	^ OrderedCollection with: self origin
]

{ #category : #transmitting }
GLMSimpleTransmission >> transmitIn: aContext [
	 
	self destination receive: self in: aContext
]

{ #category : #transmitting }
GLMSimpleTransmission >> value [ 
	 
	^self origin value
]
