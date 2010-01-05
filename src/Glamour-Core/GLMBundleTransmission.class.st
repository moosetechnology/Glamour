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
		'presentations',
		'origins'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMBundleTransmission >> activeOrigins [ 
	 
	^(self bundleOrigins select: [:each | each isActive]) 
		collect: [:each | each port]
]

{ #category : #accessing }
GLMBundleTransmission >> addActiveOrigin: aPort [ 
	 
	self bundleOrigins 
		add: 
			((GLMOriginPortReference new) 
				port: aPort; 
				beActive; 
				yourself)
]

{ #category : #accessing }
GLMBundleTransmission >> addPassiveOrigin: aPort [ 
	 
	self bundleOrigins 
		add: 
			((GLMOriginPortReference new) 
				port: aPort; 
				bePassive; 
				yourself)
]

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentations: aCollection [
	aCollection do: [:each | self addPresentation: each]
]

{ #category : #'private accessing' }
GLMBundleTransmission >> bundleOrigins [
	^ origins ifNil: [origins := OrderedCollection new]
]

{ #category : #copying }
GLMBundleTransmission >> changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser [
	| newOrigins newPort |
	super changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser.
	self bundleOrigins do: [:each | 
		newPort := each port copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser.
		each port: newPort ]
]

{ #category : #private }
GLMBundleTransmission >> clearOrigins [
	origins := nil
]

{ #category : #testing }
GLMBundleTransmission >> originatesAt: aPort [
	^ self activeOrigins includes: aPort
]

{ #category : #accessing }
GLMBundleTransmission >> origins [
	^ self bundleOrigins collect: [:each | each port]
]

{ #category : #accessing }
GLMBundleTransmission >> passiveOrigins [ 
	 
	^(self bundleOrigins select: [:each | each isPassive]) 
		collect: [:each | each port]
]

{ #category : #accessing }
GLMBundleTransmission >> presentations [ 
	self flag: 'it should be GLMCompositePresentation'.
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]

{ #category : #accessing }
GLMBundleTransmission >> presentations: aCollection [ 
	 
	presentations := aCollection
]

{ #category : #transmitting }
GLMBundleTransmission >> printOn: aStream [ 
	 
	aStream 
		nextPutAll: 'BundleTransmission (origin='; 
		nextPutAll: self origins first printString; 
		nextPutAll: ' destination='; 
		nextPutAll: self destination printString; 
		nextPut: $)
	 
	
]

{ #category : #transmitting }
GLMBundleTransmission >> transmitIn: aContext [
	self destination hasPane ifTrue: [
		self destination pane clearIn: aContext.
		self destination pane presentations: self presentations ].
	"it is important for the destination to be set after the presentation, 
	because when the presentation is a browser, we might forward the entity internally"
	self destination receive: self in: aContext.
]

{ #category : #transmitting }
GLMBundleTransmission >> value [
	^ self origins size = 1 
		ifTrue: [ self origins first value ] 
		ifFalse: [
			GLMMultiValue withAll: (self origins collect: [:each | each value]) ]
]
