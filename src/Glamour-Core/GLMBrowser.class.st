"
Browsers are one of the core components in Glamour.

They contain panes and transmission between them, which can either be explicitely defined by the user (such as in the Tabulator) or implicitely defined (such as in the Finder).

Browsers serve as composition managers. They determine when and under which conditions transmissions should be triggered and how they connect the ports of panes. In return, panes inform the browsers when event occur on their ports so that the browser can make an informed decission on what to do.

A Browser is a Presentation which means that it can be nested into other browsers.
"
Class {
	#name : #GLMBrowser,
	#superclass : #GLMPresentation,
	#traits : 'GLMTPresentationBuilder',
	#classTraits : 'GLMTPresentationBuilder classTrait',
	#instVars : [
		'transmissions',
		'panes'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMBrowser >> addPane: aPane [
	self panes add: aPane
]

{ #category : #accessing }
GLMBrowser >> addTransmission: aTransmission [ 
	^ self transmissions addLast: aTransmission
]

{ #category : #events }
GLMBrowser >> outerPortEvent: aPortEvent [  
	super outerPortEvent: aPortEvent.	
	aPortEvent hasChanged ifTrue: [
		(self transmissions select: [:each | 
			(each originatesAt: aPortEvent port) and: [
				( aPortEvent transmissionContext includesPort: each destination) not ]]) 
			do: [:each | each transmitIn: aPortEvent transmissionContext copy ]]
]

{ #category : #accessing }
GLMBrowser >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #copying }
GLMBrowser >> postCopy [
	| newPane newPanes newPanesMapping newTransmission oldPane |
	super postCopy.
	"needed for setting the right panes for the new transmissions"
	newPanesMapping := Dictionary new. 
	newPanes := OrderedCollection new.
	self panes do: [:each | 
		newPane := each copy.
		newPane browser: self.
		newPanes addLast: newPane.
		newPanesMapping at: each put: newPane ].
	oldPane := self pane.
	pane := nil.
	newPanesMapping at: oldPane ifAbsentPut: [ self pane ].
	transmissions := self transmissions collect: [ :each | 
		newTransmission := each copy.
		newTransmission 
			changePortsAccordingToPaneMapping: newPanesMapping 
			fromOldBrowser: nil
			toNewBrowser: self.
		newTransmission ].
	panes := newPanes
]

{ #category : #accessing }
GLMBrowser >> removeLastPane [
	self panes last unregisterFromAllAnnouncements.
	self panes removeLast
]

{ #category : #accessing }
GLMBrowser >> removePane: aPane [
	aPane unregisterFromAllAnnouncements.
	self panes remove: aPane
]

{ #category : #'scripting-private' }
GLMBrowser >> resolveDestinationPort: aPortReference [ 
	 
	^self resolvePort: aPortReference defaultPortName: #entity
]

{ #category : #'scripting-private' }
GLMBrowser >> resolveOriginPort: aPortReference [ 
	 
	^self resolvePort: aPortReference defaultPortName: #selection
]

{ #category : #'scripting-private' }
GLMBrowser >> resolvePort: aPortReference defaultPortName: aSymbol [ 
	 
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
GLMBrowser >> transmissions [ 
	 
	^transmissions ifNil: [transmissions := OrderedCollection new]
]

{ #category : #updating }
GLMBrowser >> unregisterFromAllAnnouncements [
	super unregisterFromAllAnnouncements.
	self panes do: [:each | 
		each presentations unregisterFromAllAnnouncements ]
]
