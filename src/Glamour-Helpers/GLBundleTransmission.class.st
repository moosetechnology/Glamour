Class {
	#name : #GLBundleTransmission,
	#superclass : #GLTransmission,
	#instVars : [
		'presentations',
		'destination',
		'origins'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLBundleTransmission >> activeOrigins [
	
	^(self bundleOrigins select: [:each | each isActive])
		collect: [:each | each port]
]

{ #category : #accessing }
GLBundleTransmission >> addActiveOrigin: aPort [
	
	self bundleOrigins
		add:
			((GLBundleOrigin new)
				port: aPort;
				beActive;
				yourself)
]

{ #category : #accessing }
GLBundleTransmission >> addPassiveOrigin: aPort [
	
	self bundleOrigins
		add:
			((GLBundleOrigin new)
				port: aPort;
				bePassive;
				yourself)
]

{ #category : #'accessing-convenience' }
GLBundleTransmission >> addPresentation: aPresentation [
	
	self presentations addLast: aPresentation
]

{ #category : #'accessing-convenience' }
GLBundleTransmission >> addPresentations: aCollection [
	
	aCollection do: [:each | self addPresentation: each]
]

{ #category : #'private accessing' }
GLBundleTransmission >> bundleOrigins [
	
	^origins ifNil: [origins := OrderedCollection new]
]

{ #category : #private }
GLBundleTransmission >> clearOrigins [
	
	origins := nil
]

{ #category : #accessing }
GLBundleTransmission >> destination [
	
	^destination
]

{ #category : #accessing }
GLBundleTransmission >> destination: aPort [
	
	destination := aPort
]

{ #category : #testing }
GLBundleTransmission >> originatesAt: aPort [
	
	^self activeOrigins includes: aPort
]

{ #category : #accessing }
GLBundleTransmission >> origins [
	
	^self bundleOrigins collect: [:each | each port]
]

{ #category : #accessing }
GLBundleTransmission >> passiveOrigins [
	
	^(self bundleOrigins select: [:each | each isPassive])
		collect: [:each | each port]
]

{ #category : #accessing }
GLBundleTransmission >> presentations [
	
	^presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #transmitting }
GLBundleTransmission >> transmit [
	
	self destination hasPane
		ifTrue:
			[self destination pane clear.
			self destination pane addPresentations: self presentations].
	self destination receive: self
]

{ #category : #transmitting }
GLBundleTransmission >> value [
	
	^self origins size = 1
		ifTrue: [self origins first value]
		ifFalse:
			[GLMultiValue withAll: (self origins collect: [:each | each value])]
]
