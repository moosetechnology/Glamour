"
The Browser is one of the core components in Glamour.

It contains panes and transmissions between their ports. These transformations can either be explicitely defined by the user (such as in the Tabulator) or implicitely defined (such as in the Finder).

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
		'panes',
		'statusPane',
		'initialExtent'
	],
	#category : #'Glamour-Core'
}

{ #category : #constants }
GLMBrowser class >> defaultStatusbarPane [
	^ #'_statusbar'
]

{ #category : #accessing }
GLMBrowser >> addDefaultStatusbarTransmissionFrom: aPane [
	| defaultTransmission |
	defaultTransmission := GLMTransmission new
		ensureBundleStrategy;
		addActiveOrigin: (aPane port: #status); 
		destination: (self statusbarPane port: #entity); 
		addPresentation: self statusbarPresentation; 
		yourself.
	self addTransmission: defaultTransmission.
]

{ #category : #accessing }
GLMBrowser >> addPane: aPane [
	aPane browser: self.
	self panes add: aPane.
	self hasStatusbar ifTrue: [
		self addDefaultStatusbarTransmissionFrom: aPane ].
	^ aPane
]

{ #category : #accessing }
GLMBrowser >> addStatusbar [
	self hasStatusbar: true
	
]

{ #category : #accessing }
GLMBrowser >> addTransmission: aTransmission [ 
	^ self transmissions addLast: aTransmission
]

{ #category : #events }
GLMBrowser >> close [
	self announce: (GLMBrowserClosed new)
]

{ #category : #accessing }
GLMBrowser >> hasStatusbar [
	^ statusPane notNil
]

{ #category : #accessing }
GLMBrowser >> hasStatusbar: aBoolean [
	aBoolean ifTrue: [
		statusPane := self addPane: (GLMPane new name: self class defaultStatusbarPane) ]
	
]

{ #category : #accessing }
GLMBrowser >> initialExtent [

	^ initialExtent ifNil: [ initialExtent := RealEstateAgent standardWindowExtent]
]

{ #category : #accessing }
GLMBrowser >> initialExtent: aPoint [

	initialExtent := aPoint
]

{ #category : #'initialize-release' }
GLMBrowser >> initialize [
	super initialize.
	panes := OrderedCollection new.
	transmissions := OrderedCollection new.
	statusPane := nil.
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
	^ panes ifNil: [	panes := OrderedCollection new ]
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
GLMBrowser >> removeAllPanes [
	self panes do: [:each | each unregisterFromAllAnnouncements].
	^ self panes removeAll
]

{ #category : #accessing }
GLMBrowser >> removeLastPane [
	self panes last unregisterFromAllAnnouncements.
	^ self panes removeLast
]

{ #category : #accessing }
GLMBrowser >> removePane: aPane [
	aPane unregisterFromAllAnnouncements.
	self panes remove: aPane
]

{ #category : #'scripting-private' }
GLMBrowser >> resolveDestinationPort: aPortReference [ 
	self flag: 'this is a temporary hack due to initializeScripting transmitting directly a port'.
	(aPortReference isKindOf: GLMPort) ifTrue: [ ^ aPortReference ].
	^self resolvePort: aPortReference asGlamourTargetIdentifier defaultPortName: #entity
]

{ #category : #'scripting-private' }
GLMBrowser >> resolveOriginPort: aPortReference [ 
	 
	^self resolvePort: aPortReference asGlamourOriginIdentifier defaultPortName: #selection
]

{ #category : #'scripting-private' }
GLMBrowser >> resolvePort: aPortReference defaultPortName: aSymbol [ 
	^ aPortReference paneName = #outer 
		ifTrue: [
			(GLMPresentationBoundPort new) 
						presentation: self; 
						name: aPortReference portName;
						yourself] 
		ifFalse: [
			(self paneNamed: aPortReference paneName) port: aPortReference portName].
]

{ #category : #accessing }
GLMBrowser >> statusbarPane [
	^ statusPane
]

{ #category : #accessing }
GLMBrowser >> statusbarPresentation [
	^ GLMLabelPresentation new
]

{ #category : #accessing }
GLMBrowser >> transmissions [ 
	^ transmissions
]

{ #category : #updating }
GLMBrowser >> unregisterFromAllAnnouncements [
	super unregisterFromAllAnnouncements.
	self panes do: [:each | 
		each unregisterFromAllAnnouncements ]
]

{ #category : #updating }
GLMBrowser >> update [ 
	self panes do: [:each | each update ].
	self announce: (GLMPresentationUpdated new presentation: self).
]
