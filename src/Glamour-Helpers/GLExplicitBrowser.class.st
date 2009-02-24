Class {
	#name : #GLExplicitBrowser,
	#superclass : #GLBrowser,
	#instVars : [
		'panes',
		'hiddenPane',
		'transmissions',
		'jumpstartTransmissions',
		'pushedPorts',
		'pulledPorts',
		'scriptTransmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLExplicitBrowser >> addJumpstart: aTransmission [
	
	self jumpstartTransmissions addLast: aTransmission
]

{ #category : #accessing }
GLExplicitBrowser >> addPane: aPane [
	
	aPane browser: self.
	self panes addLast: aPane
]

{ #category : #accessing }
GLExplicitBrowser >> addPull: aSymbol to: aContainedPort [
	"Asks the browser to push changes of aContainedPort to the outer pane's port identified by aSymbol."
	
	self pulledPorts
		add:
			((GLPublishedPort new)
				innerPort: aContainedPort;
				outerPortName: aSymbol;
				yourself)
]

{ #category : #accessing }
GLExplicitBrowser >> addPush: aContainedPort as: aSymbol [
	"Asks the browser to push changes of aContainedPort to the outer pane's port identified by aSymbol."
	
	self pushedPorts
		add:
			((GLPublishedPort new)
				innerPort: aContainedPort;
				outerPortName: aSymbol;
				yourself)
]

{ #category : #accessing }
GLExplicitBrowser >> addTransmission: aTransmission [
	
	self transmissions addLast: aTransmission
]

{ #category : #scripting }
GLExplicitBrowser >> capture: aSymbol as: aPort [
	
	self capturedPorts
		add:
			((GLPublishedPort new)
				innerPort: aPort;
				outerPortName: aSymbol;
				yourself)
]

{ #category : #scripting }
GLExplicitBrowser >> custom: aPresentation [
	
	scriptTransmission addPresentation: aPresentation.
	^aPresentation
]

{ #category : #scripting }
GLExplicitBrowser >> from: anOriginPortReference [
	
	scriptTransmission
		addActiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #events }
GLExplicitBrowser >> innerPortEvent: aPortEvent [
	
	(self pushedPorts select: [:each | each innerPort = aPortEvent port])
		do:
			[:each | (self pane port: each outerPortName) value: aPortEvent value].
	aPortEvent hasChanged
		ifTrue:
			[(self transmissions select: [:each | each originatesAt: aPortEvent port])
				do: [:each | each transmit]]
]

{ #category : #accessing }
GLExplicitBrowser >> jumpstartTransmissions [
	
	^jumpstartTransmissions
		ifNil: [jumpstartTransmissions := OrderedCollection new]
]

{ #category : #events }
GLExplicitBrowser >> outerPortEvent: aPortEvent [
	
	super outerPortEvent: aPortEvent.	"Hack for a jumpstart transmission (we should clean this up)."
	aPortEvent portName = #entity
		ifTrue:
			[self jumpstartTransmissions
				do:
					[:each | 
					each
						clearOrigins;
						addActiveOrigin: (self pane port: #entity);
						transmit]].
	aPortEvent hasChanged
		ifTrue:
			[(self transmissions select: [:each | each originatesAt: aPortEvent port])
				do: [:each | each transmit]].
	(self pulledPorts
		select: [:each | each outerPortName = aPortEvent portName])
		do: [:each | each innerPort receive: aPortEvent transmission]
]

{ #category : #accessing }
GLExplicitBrowser >> paneNamed: aSymbol [
	
	^self panes detect: [:each | each name = aSymbol]
]

{ #category : #accessing }
GLExplicitBrowser >> panes [
	
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #scripting }
GLExplicitBrowser >> passivelyFrom: anOriginPortReference [
	
	scriptTransmission
		addPassiveOrigin: (self resolveOriginPort: anOriginPortReference)
]

{ #category : #scripting }
GLExplicitBrowser >> publish: aPort as: aSymbol [
	
	self publishedPorts
		add:
			((GLPublishedPort new)
				innerPort: aPort;
				outerPortName: aSymbol;
				yourself)
]

{ #category : #scripting }
GLExplicitBrowser >> pull: anOuterPortSymbol to: anInnerPortReference [
	
	self
		addPull: anOuterPortSymbol
		to: (self resolveOriginPort: anInnerPortReference)
]

{ #category : #accessing }
GLExplicitBrowser >> pulledPorts [
	
	^pulledPorts ifNil: [pulledPorts := OrderedCollection new]
]

{ #category : #scripting }
GLExplicitBrowser >> push: anInnerPortReference as: anOuterPortSymbol [
	
	self
		addPush: (self resolveOriginPort: anInnerPortReference)
		as: anOuterPortSymbol
]

{ #category : #accessing }
GLExplicitBrowser >> pushedPorts [
	
	^pushedPorts ifNil: [pushedPorts := OrderedCollection new]
]

{ #category : #'scripting-private' }
GLExplicitBrowser >> resolveDestinationPort: aPortReference [
	
	^self resolvePort: aPortReference defaultPortName: #entity
]

{ #category : #'scripting-private' }
GLExplicitBrowser >> resolveOriginPort: aPortReference [
	
	^self resolvePort: aPortReference defaultPortName: #selection
]

{ #category : #'scripting-private' }
GLExplicitBrowser >> resolvePort: aPortReference defaultPortName: aSymbol [
	
	| tmp |
	tmp := aPortReference.
	(tmp isKindOf: GLPane) ifTrue: [tmp := tmp port: aSymbol].
	(tmp isKindOf: GLPort) ifTrue: [^tmp].
	tmp isSymbol ifTrue: [tmp := tmp -> aSymbol].
	(tmp isKindOf: Association)
		ifTrue:
			[^tmp key = #outer
				ifTrue:
					[(GLParentPort new)
						presentation: self;
						name: tmp value;
						yourself]
				ifFalse: [(self paneNamed: tmp key) port: tmp value]].
	self error: 'Unknown port reference.'
]

{ #category : #scripting }
GLExplicitBrowser >> sendTo: aDesinationPortReference from: anOriginPortReference [
	
	self transmissions
		addLast:
			((GLSimpleTransmission new)
				origin: (self resolveOriginPort: anOriginPortReference);
				destination: (self resolveDestinationPort: aDesinationPortReference);
				yourself)
]

{ #category : #scripting }
GLExplicitBrowser >> showOn: aDestinationPane [
	
	scriptTransmission := (GLBundleTransmission new)
		destination: (self resolveDestinationPort: aDestinationPane);
		yourself
]

{ #category : #accessing }
GLExplicitBrowser >> transmissions [
	
	^transmissions ifNil: [transmissions := OrderedCollection new]
]

{ #category : #scripting }
GLExplicitBrowser >> using: aBlock [
	
	aBlock value.
	scriptTransmission origins isEmpty
		ifTrue: [self addJumpstart: scriptTransmission]
		ifFalse: [self addTransmission: scriptTransmission].
	scriptTransmission := nil
]
