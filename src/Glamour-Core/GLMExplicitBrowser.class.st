"
A GLMExplicitBrowser is a browser that allows the user to explicitly define the panes and the flow of transmissions between them.
"
Class {
	#name : #GLMExplicitBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'panes',
		'transmissions'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMExplicitBrowser >> addNewPane [
	
	^self addNewPaneNamed: 'undefined'
]

{ #category : #accessing }
GLMExplicitBrowser >> addNewPaneNamed: aString [
	
	^self panes addLast: (GLMPane named: aString in: self)
]

{ #category : #accessing }
GLMExplicitBrowser >> addPane: aPane [ 
	 
	aPane browser: self. 
	self panes addLast: aPane
]

{ #category : #accessing }
GLMExplicitBrowser >> addTransmission: aTransmission [ 
	 
	^ self transmissions addLast: aTransmission
]

{ #category : #events }
GLMExplicitBrowser >> innerPortEvent: aPortEvent [ 
	| wantedTransmissions |
	aPortEvent hasChanged ifTrue: [
		wantedTransmissions := self transmissions select: [:each | 
			( each originatesAt: aPortEvent port ) and: [
				( aPortEvent transmissionContext includesPort: each destination ) not ]].
		wantedTransmissions do: [ :each | each transmitIn: aPortEvent transmissionContext copy ]]
]

{ #category : #accessing }
GLMExplicitBrowser >> lastTransmission [
	^ self transmissions last
]

{ #category : #events }
GLMExplicitBrowser >> outerPortEvent: aPortEvent [  
	super outerPortEvent: aPortEvent.	
	aPortEvent hasChanged ifTrue: [
		(self transmissions select: [:each | 
			(each originatesAt: aPortEvent port) and: [
				( aPortEvent transmissionContext includesPort: each destination) not ]]) 
			do: [:each | each transmitIn: aPortEvent transmissionContext copy ]]
]

{ #category : #accessing }
GLMExplicitBrowser >> paneNamed: aSymbol [ 
	 
	^self panes detect: [:each | each name = aSymbol]
]

{ #category : #accessing }
GLMExplicitBrowser >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #copying }
GLMExplicitBrowser >> postCopy [
	| newPane newPanes newPanesMapping newTransmission oldPane |
	super postCopy.
	"needed for setting the right panes for the new transmissions"
	newPanesMapping := Dictionary new. 
	newPanes := OrderedCollection new.
	panes do: [:each | 
		newPane := each copy.
		newPane browser: self.
		newPanes addLast: newPane.
		newPanesMapping at: each put: newPane ].
	oldPane := self pane.
	pane := nil.
	newPanesMapping at: oldPane ifAbsentPut: [ self pane ].
	transmissions := self transmissions collect: [:each | 
		newTransmission := each copy.
		newTransmission changePortsAccordingToPaneMapping: newPanesMapping fromOldBrowser: nil toNewBrowser: self.
		newTransmission ].
	panes := newPanes
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
					[(GLMPresentationBoundPort new) 
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

{ #category : #accessing }
GLMExplicitBrowser >> updateContextWith: aPane [ 

]
