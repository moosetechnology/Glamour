Class {
	#name : #GLMAccumulator,
	#superclass : #GLMImplicitBrowser,
	#instVars : [
		'cell'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLMAccumulator >> addPaneFrom: aPort [ 
	| lastActivePresentation |
	self panes withIndexDo: [:each :i | 
		(each port: #entity) value = aPort value ifTrue: [
			self announce: 
				(GLMPaneSelected 
					pane: each 
					atPosition: i
					inBrowser: self).
			^ self ]]. 
	self panes addLast: (GLMPane in: self).
	GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: aPort; 
		destination: (self panes last port: #entity); 
		presentations: (self presentations copy); 
		transmit.
	self announce: 
			(GLMPaneAdded 
				pane: self panes last 
				atPosition: self panes size 
				inBrowser: self)
]

{ #category : #events }
GLMAccumulator >> innerPortEvent: aPortEvent [ 
	aPortEvent portName = #entity ifFalse: [
		"We don't want to resend the transmission, but use a new SimpleTransmission." 
		(self pane port: aPortEvent portName) value: aPortEvent value]
]

{ #category : #events }
GLMAccumulator >> outerPortEvent: aPortEvent [ 
 	super outerPortEvent: aPortEvent.
	aPortEvent port name = #entity ifFalse: [^self].
	self addPaneFrom: aPortEvent port
]

{ #category : #private }
GLMAccumulator >> removePaneIndex: i [
	| paneRemoved |
	paneRemoved := self panes removeAt: i.
	self announce: (GLMPaneRemoved pane: paneRemoved fromBrowser: self )
]

{ #category : #rendering }
GLMAccumulator >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderAccumulator: self
]
