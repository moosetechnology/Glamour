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
		'destination',
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
			((GLMBundleOrigin new) 
				port: aPort; 
				beActive; 
				yourself)
]

{ #category : #accessing }
GLMBundleTransmission >> addPassiveOrigin: aPort [ 
	 
	self bundleOrigins 
		add: 
			((GLMBundleOrigin new) 
				port: aPort; 
				bePassive; 
				yourself)
]

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentation: aPresentation [ 
	 
	self presentations addLast: aPresentation
]

{ #category : #'accessing-convenience' }
GLMBundleTransmission >> addPresentations: aCollection [ 
	 
	aCollection do: [:each | self addPresentation: each]
]

{ #category : #'private accessing' }
GLMBundleTransmission >> bundleOrigins [ 
	 
	^origins ifNil: [origins := OrderedCollection new]
]

{ #category : #private }
GLMBundleTransmission >> clearOrigins [ 
	 
	origins := nil
]

{ #category : #accessing }
GLMBundleTransmission >> destination [ 
	 
	^destination
]

{ #category : #accessing }
GLMBundleTransmission >> destination: aPort [ 
	 
	destination := aPort
]

{ #category : #testing }
GLMBundleTransmission >> originatesAt: aPort [ 
	 
	^self activeOrigins includes: aPort
]

{ #category : #accessing }
GLMBundleTransmission >> origins [ 
	 
	^self bundleOrigins collect: [:each | each port]
]

{ #category : #accessing }
GLMBundleTransmission >> passiveOrigins [ 
	 
	^(self bundleOrigins select: [:each | each isPassive]) 
		collect: [:each | each port]
]

{ #category : #accessing }
GLMBundleTransmission >> presentations [ 
	 
	^presentations ifNil: [presentations := OrderedCollection new]
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
GLMBundleTransmission >> transmit [ 
	 
	self destination hasPane 
		ifTrue: 
			[self destination pane clear.
			self destination pane addPresentations: self presentations]. 
	self destination receive: self
]

{ #category : #transmitting }
GLMBundleTransmission >> value [ 
	 
	^self origins size = 1 
		ifTrue: [self origins first value] 
		ifFalse: 
			[GLMMultiValue withAll: (self origins collect: [:each | each value])]
]
