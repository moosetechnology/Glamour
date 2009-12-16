"
A port that belongs to a pane.

Bound ports have a few special characteristics in comparison to their superclass. For one, they don't just assign a value to themselves using #value: but rather generate a transmission that set the value so that the pane can handle the transmission and forward it to other ports if necessary, depending on the policy of the containing browser.
"
Class {
	#name : #GLMPanePort,
	#superclass : #GLMBoundPort,
	#instVars : [
		'pane',
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPanePort >> basicValue: anObject [
	value := anObject. 
	
]

{ #category : #accessing }
GLMPanePort >> changeValueTo: anObject in: aTransmissionContext [
	| oldValue | 
	oldValue := self value. 
	self pane notingPresentationChangeDo: [
		value := anObject. 
		self pane portEvent: 
					(GLMPortEvent 
						on: self
						previouslyValued: oldValue
						in: aTransmissionContext) ]
]

{ #category : #accessing }
GLMPanePort >> pane [ 
	 
	^pane
]

{ #category : #accessing }
GLMPanePort >> pane: aPane [ 
	 
	pane := aPane
]

{ #category : #accessing }
GLMPanePort >> printOn: aStream [ 
	 
	aStream 
		nextPutAll: 'Port (pane='; 
		nextPutAll: self pane name printString; 
		nextPutAll: ' name='; 
		nextPutAll: self name printString; 
		nextPutAll: ' value='; 
		nextPutAll: self value printString; 
		nextPut: $)
]

{ #category : #accessing }
GLMPanePort >> receive: aTransmission [ 
	 
	self value: aTransmission value in: aTransmission context
]

{ #category : #accessing }
GLMPanePort >> receive: aTransmission in: aContext [
	 
	self value: aTransmission value in: aContext
]

{ #category : #accessing }
GLMPanePort >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMPanePort >> value: anObject [ 
	(self validate: anObject) ifFalse: [^ self].
	self changeValueTo: anObject in: OrderedCollection new.
]

{ #category : #accessing }
GLMPanePort >> value: anObject in: aContext [
	aContext add: self.
	self changeValueTo: anObject in: aContext.
]
