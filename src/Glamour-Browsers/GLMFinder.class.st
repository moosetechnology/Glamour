"
A GLMFinder models a browsers that behaves like the Mac Finder: whenever the selection port is set on one pane, a new one is created to the right with the selection as entity. The Finder opens the first pane on the entity.

Input ports:
- entity: this is passed to the first pane

Output ports:
- selection: this port is populated with the value from the last selection port from one of the panes
"
Class {
	#name : #GLMFinder,
	#superclass : #GLMImplicitBrowser,
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLMFinder >> addPaneFrom: aPort [ 
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

{ #category : #private }
GLMFinder >> addPaneFromInner: aPort [ 
	| newTransmission realTransmissions lastActivePresentation |
	"the lastActivePresentation is needed for knowing what presentation to show by default"
	self panes isEmpty ifFalse: [lastActivePresentation := self panes last lastActivePresentation ].
	self panes addLast: ( (GLMPane in: self) lastActivePresentation: lastActivePresentation; yourself).
	GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: aPort; 
		destination: (self panes last port: #entity); 
		presentations: (self presentations copy); 
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
"	self 
		announce: 
			(GLMPaneAdded 
				pane: self panes last 
				atPosition: self panes size 
				inBrowser: self)"
]

{ #category : #events }
GLMFinder >> innerPortEvent: aPortEvent [ 
	aPortEvent portName = #entity ifFalse: [
		"We don't want to resend the transmission, but use a new SimpleTransmission." 
		(self pane port: aPortEvent portName) value: aPortEvent value]. 

	aPortEvent port name = #selection ifTrue: [
		| index toReplace |
		index := self panes reversed indexOf: aPortEvent pane.
		(self panes reversed first: index - 2) do: [ :each |  
			self removeLastPane.
			self announce: (GLMPaneRemoved pane: each fromBrowser: self) ].
		index <= 1 
			ifTrue: [ 
				self addPaneFromInner: aPortEvent port.
				self announce: 
					(GLMPaneAdded 
						pane: self panes last 
						atPosition: self panes size 
						inBrowser: self) ]
			ifFalse: [
				toReplace := self removeLastPane.
				self addPaneFromInner: aPortEvent port.
				self announce: (GLMPaneReplaced 
							oldPane: toReplace 
							newPane: self panes last
							fromBrowser: self ) ] 
	]
]

{ #category : #events }
GLMFinder >> outerPortEvent: aPortEvent [ 
	 
	aPortEvent port name = #entity ifFalse: [^self]. 
	panes := nil. 
	self addPaneFrom: aPortEvent port
]

{ #category : #rendering }
GLMFinder >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderFinder: self
]
