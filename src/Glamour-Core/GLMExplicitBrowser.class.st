Class {
	#name : #GLMExplicitBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'panes',
		'hiddenPane',
		'transmissions',
		'jumpstartTransmissions',
		'scriptTransmission',
		'context'
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
GLMExplicitBrowser >> addTransmission: aTransmission [ 
	 
	self transmissions addLast: aTransmission
]

{ #category : #events }
GLMExplicitBrowser >> innerPortEvent: aPortEvent [ 
	aPortEvent hasChanged 
		ifTrue: 
			[(self transmissions select: [:each | ( each originatesAt: aPortEvent port ) and: [( aPortEvent pane browser context includes: each destination pane) not ]]) 
				do: [:each | each transmitIn: aPortEvent transmissionContext]]
]

{ #category : #accessing }
GLMExplicitBrowser >> jumpstartTransmissions [ 
	 
	^jumpstartTransmissions 
		ifNil: [jumpstartTransmissions := OrderedCollection new]
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
			[(self transmissions select: [:each | ( each originatesAt: aPortEvent port ) and: [( aPortEvent transmissionContext includes: each) not ]]) 
				do: [:each | each transmitIn: aPortEvent transmissionContext]]
]

{ #category : #accessing }
GLMExplicitBrowser >> paneNamed: aSymbol [ 
	 
	^self panes detect: [:each | each name = aSymbol]
]

{ #category : #accessing }
GLMExplicitBrowser >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
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
	tmp := aPortReference. 
	(tmp isKindOf: GLMPane) ifTrue: [tmp := tmp port: aSymbol]. 
	(tmp isKindOf: GLMPort) ifTrue: [^tmp]. 
	tmp isSymbol ifTrue: [tmp := tmp -> aSymbol]. 
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
	 
	^transmissions ifNil: [transmissions := OrderedCollection new]
]
