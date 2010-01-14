"
A GLMTransmission models the connection between pane ports. Whenever a port changes the value, the corresponding transmissions are triggered by the browser.

The subclasses add different semantics to this connection.

A transmission takes place in a context. The context is started every time a new value is set from outside. Afterwards, the context is preserved internally. This is important for braking possible loops of propagation of transmissions.
"
Class {
	#name : #GLMTransmission,
	#superclass : #Object,
	#instVars : [
		'context',
		'destination',
		'browser',
		'origins',
		'transmissionStrategy',
		'transformation'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMTransmission >> activeOrigins [ 
	 
	^(self originReferences select: [:each | each isActive]) 
		collect: [:each | each port]
]

{ #category : #accessing }
GLMTransmission >> addActiveOrigin: aPort [ 
	^ self originReferences 
		add: 
			((GLMOriginPortReference new) 
				port: aPort; 
				beActive; 
				yourself)
]

{ #category : #accessing }
GLMTransmission >> addPassiveOrigin: aPort [
	^ self originReferences 
		add: 
			((GLMOriginPortReference new) 
				port: aPort; 
				bePassive; 
				yourself)
]

{ #category : #accessing }
GLMTransmission >> addPresentation: aPresentation [
	self transmissionStrategy addPresentation: aPresentation
]

{ #category : #accessing }
GLMTransmission >> addPresentations: aCollection [
	self transmissionStrategy addPresentations: aCollection
]

{ #category : #accessing }
GLMTransmission >> browser [
	^ browser
]

{ #category : #accessing }
GLMTransmission >> browser: anObject [
	browser := anObject
]

{ #category : #copying }
GLMTransmission >> changePortsAccordingToPaneMapping: newPanesMapping [
	"newPanesMapping is a dictionary with 
	keys given by old panes and values by new panes"
	self destination: ((newPanesMapping at: self destination pane) port: self destination name).

]

{ #category : #copying }
GLMTransmission >> changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser [
	| newOrigins newPort |
"	super changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: aBrowser toNewBrowser: anotherBrowser.
"
	"newPanesMapping is a dictionary with 
	keys given by old panes and values by new panes"
	self destination: (self destination copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser).
	self originReferences do: [:each | 
		newPort := each port copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser.
		each port: newPort ]
]

{ #category : #transmitting }
GLMTransmission >> context [
	 context ifNil: [context := OrderedCollection new].
	^context
]

{ #category : #transmitting }
GLMTransmission >> context: aContext [
	 context := aContext
]

{ #category : #accessing }
GLMTransmission >> destination [ 
	 
	^destination
]

{ #category : #accessing }
GLMTransmission >> destination: aPort [ 
	 
	destination := aPort
]

{ #category : #'initialize-release' }
GLMTransmission >> initialize [
	transmissionStrategy := GLMTransmissionStrategy new
]

{ #category : #'private accessing' }
GLMTransmission >> originReferences [
	^ origins ifNil: [origins := OrderedCollection new]
]

{ #category : #testing }
GLMTransmission >> originatesAt: aPort [
	^ self activeOrigins includes: aPort
]

{ #category : #accessing }
GLMTransmission >> origins [
	^ self originReferences collect: [:each | each port]
]

{ #category : #accessing }
GLMTransmission >> passiveOrigins [ 
	 
	^(self originReferences select: [:each | each isPassive]) 
		collect: [:each | each port]
]

{ #category : #copying }
GLMTransmission >> postCopy [
	origins := origins collect: [:each | each copy ].
	strategyBeforeValue := strategyBeforeValue copy.
	strategyBeforeValue transmission: self
]

{ #category : #accessing }
GLMTransmission >> presentations [
	^ self transmissionStrategy presentations
]

{ #category : #transmitting }
GLMTransmission >> printOn: aStream [ 
	 
	aStream 
		nextPutAll: self class name;
		nextPutAll: ' (origins='; 
		nextPutAll: self origins first printString; 
		nextPutAll: ' destination='; 
		nextPutAll: self destination printString; 
		nextPut: $)
	 
	
]

{ #category : #accessing }
GLMTransmission >> transformation [
	^ transformation
]

{ #category : #accessing }
GLMTransmission >> transformation: anObject [ 
	 
	transformation := anObject
]

{ #category : #accessing }
GLMTransmission >> transmissionStrategy [
	^ transmissionStrategy
]

{ #category : #accessing }
GLMTransmission >> transmissionStrategy: anObject [
	transmissionStrategy := anObject
]

{ #category : #transmitting }
GLMTransmission >> transmit [
	self transmitIn: GLMTransmissionContext new
]

{ #category : #transmitting }
GLMTransmission >> transmitIn: aContext [
	self transmissionStrategy transmitIn: aContext.
	self destination receive: self in: aContext.
]

{ #category : #transmitting }
GLMTransmission >> value [
	| originalValue |
	originalValue := self originReferences size = 1 
		ifTrue: [ self originReferences first value ] 
		ifFalse: [ GLMMultiValue withAll: (self originReferences collect: [:each | each value]) ].
	^ self transformation isNil 
		ifTrue: [ originalValue ] 
		ifFalse: [ self transformation glamourValue: originalValue ]
]
