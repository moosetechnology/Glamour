"
GLMExpander aims to implement a Hopscotch-like browser
"
Class {
	#name : #GLMExpander,
	#superclass : #GLMImplicitBrowser,
	#instVars : [
		'rootPane'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #events }
GLMExpander >> addPaneFrom: aPort [ 
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
GLMExpander >> innerPortEvent: aPortEvent [ 
	 
	aPortEvent portName = #entity ifFalse: [
		"We don't want to resend the transmission, but use a new SimpleTransmission." 
		(self pane port: aPortEvent portName) value: aPortEvent value]. 
	aPortEvent port name = #selection ifTrue: [
		(self panes reversed copyUpTo: aPortEvent pane) do: [ :each |  
			self removeLastPane.
			self announce: (GLMPaneRemoved pane: each fromBrowser: self) ]. 
		self addPaneFromInner: aPortEvent port ]
]

{ #category : #events }
GLMExpander >> outerPortEvent: aPortEvent [ 
	 
	aPortEvent port name = #entity ifFalse: [^self]. 
	panes := nil. 
	aPortEvent port value do: [:each |
		self addPaneFrom: (GLMSimplePort new value: each) ]
]

{ #category : #rendering }
GLMExpander >> renderGlamorouslyOn: aRenderer [ 
	^ aRenderer renderExpander: self
]
