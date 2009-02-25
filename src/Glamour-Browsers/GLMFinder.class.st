Class {
	#name : #GLMFinder,
	#superclass : #GLMImplicitBrowser,
	#instVars : [
		'panes',
		'presentations'
	],
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLMFinder >> addPaneFrom: aPort [ 
	 
	self panes 
		addLast: 
			((GLMPane new) 
				browser: self; 
				yourself). 
	(GLMBundleTransmission new) 
		addActiveOrigin: aPort; 
		destination: (self panes last port: #entity); 
		addPresentations: (self presentations collect: [:each | each copy]); 
		transmit. 
	self 
		announce: 
			(GLMPaneAdded 
				pane: self panes last 
				atPosition: self panes size 
				inBrowser: self)
]

{ #category : #accessing }
GLMFinder >> addPresentation: aPresentation [ 
	 
	self presentations addLast: aPresentation
]

{ #category : #events }
GLMFinder >> innerPortEvent: aPortEvent [ 
	 
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
					self announce: (GLMPaneRemoved pane: each fromBrowser: self)]. 
			self addPaneFrom: aPortEvent port]
]

{ #category : #events }
GLMFinder >> outerPortEvent: aPortEvent [ 
	 
	aPortEvent port name ~= #entity ifTrue: [^self]. 
	panes := nil. 
	self addPaneFrom: aPortEvent port
]

{ #category : #accessing }
GLMFinder >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #accessing }
GLMFinder >> presentations [ 
	 
	^presentations ifNil: [presentations := OrderedCollection new]
]

{ #category : #rendering }
GLMFinder >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderFinder: self
]
