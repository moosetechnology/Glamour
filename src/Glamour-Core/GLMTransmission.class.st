"
A GLMTransmission models the connection between pane ports. Whenever a port changes the value, the corresponding transmissions are triggered by the browser.

The subclasses add different semantics to this connection.

A transmission takes place in a context. The context is started every time a new value is set from outside. Afterwards, the context is preserved internally. This is important for braking possible loops of propagation of transmissions.
"
Class {
	#name : #GLMTransmission,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #'Glamour-Core'
}

{ #category : #transmitting }
GLMTransmission >> context [
	 context ifNil: [context := OrderedCollection new].
	^context
]

{ #category : #transmitting }
GLMTransmission >> context: aContext [
	 context := aContext
]

{ #category : #testing }
GLMTransmission >> originatesAt: aPort [ 
	 
	^false
]

{ #category : #transmitting }
GLMTransmission >> transmit [ 
	 
	self subclassResponsibility
]

{ #category : #transmitting }
GLMTransmission >> value [ 
	 
	self subclassResponsibility
]
