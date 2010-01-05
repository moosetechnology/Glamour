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
		'browser'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMTransmission >> addActiveOrigin: aPort [
	self subclassResponsibility 
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
	"newPanesMapping is a dictionary with 
	keys given by old panes and values by new panes"
	self destination: (self destination copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser)
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

{ #category : #testing }
GLMTransmission >> originatesAt: aPort [ 
	 
	^false
]

{ #category : #transmitting }
GLMTransmission >> transmit [
	self transmitIn: GLMTransmissionContext new
]

{ #category : #transmitting }
GLMTransmission >> transmitIn: aContext [
	self subclassResponsibility
]

{ #category : #transmitting }
GLMTransmission >> value [ 
	 
	self subclassResponsibility
]
