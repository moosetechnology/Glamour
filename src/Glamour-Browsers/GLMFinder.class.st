Class {
	#name : #GLMFinder,
	#superclass : #GLMImplicitBrowser,
	#instVars : [
		'panes',
		'presentations',
		'transmissions',
		'scriptTransmission',
		'context'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLMFinder >> addPaneFrom: aPort [ 
	 
	self panes addLast: ( GLMPane in: self ). 
	GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: aPort; 
		destination: (self panes last port: #entity); 
		addPresentations: (self presentations collect: [:each | each copy]); 
		transmit.
	self announce: 
			(GLMPaneAdded 
				pane: self panes last 
				atPosition: self panes size 
				inBrowser: self)
]

{ #category : #private }
GLMFinder >> addPaneFromInner: aPort [ 
	 
	| newTransmission realTransmissions | 
	self panes addLast: (GLMPane in: self ). 
	GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: aPort; 
		destination: (self panes last port: #entity); 
		addPresentations: (self presentations collect: [:each | each copy]); 
		transmit. 
	realTransmissions := self transmissions collect: [:each |  
			newTransmission := GLMTransmission new ensureBundleStrategy. 
			each activeOrigins do: [:eachPort | 
				newTransmission addActiveOrigin: (aPort pane port: eachPort name)]. 
			each passiveOrigins do: [:eachPort | 
				newTransmission addPassiveOrigin: (aPort pane port: eachPort name)]. 
			newTransmission 
				destination: (self panes last port: #entity); 
				addPresentations: (self presentations collect: #copy);
				addPresentations: (each presentations collect: #copy)] . 
	(realTransmissions select: [:each | each originatesAt: aPort]) 
		do: [:each | each transmit]. 
	self 
		announce: 
			(GLMPaneAdded 
				pane: self panes last 
				atPosition: self panes size 
				inBrowser: self)
]

{ #category : #accessing }
GLMFinder >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #accessing }
GLMFinder >> addTransmission: aTransmission [ 
	 
	self transmissions addLast: aTransmission
]

{ #category : #events }
GLMFinder >> innerPortEvent: aPortEvent [ 
	 
	aPortEvent portName = #entity ifFalse: [
		"We don't want to resend the transmission, but use a new SimpleTransmission." 
		(self pane port: aPortEvent portName) value: aPortEvent value]. 
	aPortEvent port name = #selection ifTrue: [
		(self panes reverse copyUpTo: aPortEvent pane) do: [:each |  
					self panes removeLast. 
					self announce: (GLMPaneRemoved pane: each fromBrowser: self)]. 
		self addPaneFromInner: aPortEvent port]
]

{ #category : #events }
GLMFinder >> outerPortEvent: aPortEvent [ 
	 
	aPortEvent port name = #entity ifFalse: [^self]. 
	panes := nil. 
	self addPaneFrom: aPortEvent port
]

{ #category : #accessing }
GLMFinder >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #accessing }
GLMFinder >> presentations [ 
	 
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]

{ #category : #rendering }
GLMFinder >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderFinder: self
]

{ #category : #accessing }
GLMFinder >> transmissions [ 
	 
	^transmissions ifNil: [transmissions := OrderedCollection new]
]
