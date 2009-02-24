Class {
	#name : #GLFinder,
	#superclass : #GLImplicitBrowser,
	#instVars : [
		'panes',
		'presentations'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLFinder >> addPaneFrom: aPort [
	
	self panes
		addLast:
			((GLPane new)
				browser: self;
				yourself).
	(GLBundleTransmission new)
		addActiveOrigin: aPort;
		destination: (self panes last port: #entity);
		addPresentations: (self presentations collect: [:each | each copy]);
		transmit.
	self
		announce:
			(GLPaneAdded
				pane: self panes last
				atPosition: self panes size
				inBrowser: self)
]

{ #category : #accessing }
GLFinder >> addPresentation: aPresentation [
	
	self presentations addLast: aPresentation
]

{ #category : #scripting }
GLFinder >> custom: aPresentation [
	
	self addPresentation: aPresentation.
	^aPresentation
]

{ #category : #events }
GLFinder >> innerPortEvent: aPortEvent [
	
	aPortEvent portName ~= #entity
		ifTrue:
			["We don't want to resend the transmission, but use a new SimpleTransmission."
			(self pane port: aPortEvent portName) value: aPortEvent value].
	aPortEvent port name ~= #selection
		ifFalse:
			[(self panes reverse copyUpTo: aPortEvent pane)
				do:
					[:each | 
					self panes removeLast.
					self announce: (GLPaneRemoved pane: each fromBrowser: self)].
			self addPaneFrom: aPortEvent port]
]

{ #category : #events }
GLFinder >> outerPortEvent: aPortEvent [
	
	aPortEvent port name ~= #entity ifTrue: [^self].
	panes := nil.
	self addPaneFrom: aPortEvent port
]

{ #category : #accessing }
GLFinder >> panes [
	
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #accessing }
GLFinder >> presentations [
	
	^presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #rendering }
GLFinder >> renderGlamorouslyOn: aRenderer [
	
	^aRenderer renderFinder: self
]
