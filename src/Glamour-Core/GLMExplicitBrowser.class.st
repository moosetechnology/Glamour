Class {
	#name : #GLMExplicitBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'panes',
		'hiddenPane',
		'transmissions',
		'jumpstartTransmissions',
		'scriptTransmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMExplicitBrowser >> addJumpstart: aTransmission [ 
	 
	self jumpstartTransmissions addLast: aTransmission
]

{ #category : #accessing }
GLMExplicitBrowser >> addPane: aPane [ 
	 
	aPane browser: self. 
	self panes addLast: aPane
]

{ #category : #accessing }
GLMExplicitBrowser >> addPull: aSymbol to: aContainedPort [ 
	"Asks the browser to push changes of aContainedPort to the outer pane's port identified by aSymbol." 
	 
	self pulledPorts 
		add: 
			((GLMPublishedPort new) 
				innerPort: aContainedPort; 
				outerPortName: aSymbol; 
				yourself)
]

{ #category : #accessing }
GLMExplicitBrowser >> addPush: aContainedPort as: aSymbol [ 
	"Asks the browser to push changes of aContainedPort to the outer pane's port identified by aSymbol." 
	 
	self pushedPorts 
		add: 
			((GLMPublishedPort new) 
				innerPort: aContainedPort; 
				outerPortName: aSymbol; 
				yourself)
]

{ #category : #accessing }
GLMExplicitBrowser >> addTransmission: aTransmission [ 
	 
	self transmissions addLast: aTransmission
]

{ #category : #events }
GLMExplicitBrowser >> innerPortEvent: aPortEvent [ 
	 
	aPortEvent hasChanged 
		ifTrue: 
			[(self transmissions select: [:each | each originatesAt: aPortEvent port]) 
				do: [:each | each transmit]]
]

{ #category : #accessing }
GLMExplicitBrowser >> jumpstartTransmissions [ 
	 
	^jumpstartTransmissions 
		ifNil: [jumpstartTransmissions _ OrderedCollection new]
]

{ #category : #events }
GLMExplicitBrowser >> outerPortEvent: aPortEvent [ 
	 
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
				do: [:each | each transmit]]
]

{ #category : #accessing }
GLMExplicitBrowser >> paneNamed: aSymbol [ 
	 
	^self panes detect: [:each | each name = aSymbol]
]

{ #category : #accessing }
GLMExplicitBrowser >> panes [ 
	 
	^panes ifNil: [panes _ OrderedCollection new]
]

{ #category : #accessing }
GLMExplicitBrowser >> pulledPorts [ 
	 
	^pulledPorts ifNil: [pulledPorts := OrderedCollection new]
]

{ #category : #accessing }
GLMExplicitBrowser >> pushedPorts [ 
	 
	^pushedPorts ifNil: [pushedPorts := OrderedCollection new]
]

{ #category : #'scripting-private' }
GLMExplicitBrowser >> resolveDestinationPort: aPortReference [ 
	 
	^self resolvePort: aPortReference defaultPortName: #entity
]

{ #category : #'scripting-private' }
GLMExplicitBrowser >> resolveOriginPort: aPortReference [ 
	 
	^self resolvePort: aPortReference defaultPortName: #selection
]

{ #category : #'scripting-private' }
GLMExplicitBrowser >> resolvePort: aPortReference defaultPortName: aSymbol [ 
	 
	| tmp | 
	tmp _ aPortReference. 
	(tmp isKindOf: GLMPane) ifTrue: [tmp _ tmp port: aSymbol]. 
	(tmp isKindOf: GLMPort) ifTrue: [^tmp]. 
	tmp isSymbol ifTrue: [tmp _ tmp -> aSymbol]. 
	(tmp isKindOf: Association) 
		ifTrue: 
			[^tmp key = #outer 
				ifTrue: 
					[(GLMParentPort new) 
						presentation: self; 
						name: tmp value; 
						yourself] 
				ifFalse: [(self paneNamed: tmp key) port: tmp value]]. 
	self error: 'Unknown port reference.'
]

{ #category : #accessing }
GLMExplicitBrowser >> transmissions [ 
	 
	^transmissions ifNil: [transmissions _ OrderedCollection new]
]
