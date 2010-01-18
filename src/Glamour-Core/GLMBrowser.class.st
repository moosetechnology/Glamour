"
Browsers are one of the core components in Glamour.

They contain panes and transmission between them, which can either be explicitely defined by the user (such as in the TableLayoutBrowser) or implicitely defined (such as in the Finder).

Browsers serve as composition managers. They determine when and under which conditions transmissions should be triggered and how they connect the ports of panes. In return, panes inform the browsers when event occur on their ports so that the browser can make an informed decission on what to do.

A Browser is a Presentation which means that it can be nested into other browsers.
"
Class {
	#name : #GLMBrowser,
	#superclass : #GLMPresentation,
	#traits : 'GLMTPresentationBuilder',
	#classTraits : 'GLMTPresentationBuilder classTrait',
	#instVars : [
		'transmissions'
	],
	#category : #'Glamour-Core'
}

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
	"Return an (ordered) collection of the panes used by this browser." 
	 
	self subclassResponsibility
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
