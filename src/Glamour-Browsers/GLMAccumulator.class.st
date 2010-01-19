"
An GLMAccumulator is an implicit type of browser that has the following behavior:
- each input entity has associated a pane without any relationship with the other panes
- based on the input entity if there already exists a pane associated, it is selected via GLMPaneSelected
- if there isnt a pane, a new pane is created
- based on entityToSelect, the associated pane is searched and potentially selected

Input ports:
- entity
- entityToSelect

Output ports:
- selection
"
Class {
	#name : #GLMAccumulator,
	#superclass : #GLMImplicitBrowser,
	#category : #'Glamour-Browsers'
}

{ #category : #private }
GLMAccumulator >> addPaneFrom: aPort [ 
	| lastActivePresentation |
	self panes withIndexDo: [:each :i | 
		(each port: #entity) value = aPort value ifTrue: [
			self announce: 
				(GLMPaneSelected 
					pane: each 
					atPosition: i
					inBrowser: self).
			^ self ]]. 
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

{ #category : #'accessing ports' }
GLMAccumulator >> entityToSelect: anObject [
	^ (self pane port: #entityToSelect) value: anObject 
]

{ #category : #events }
GLMAccumulator >> innerPortEvent: aPortEvent [ 
	aPortEvent portName = #entity ifFalse: [
		"We don't want to resend the transmission, but use a new SimpleTransmission." 
		(self pane port: aPortEvent portName) value: aPortEvent value]
]

{ #category : #events }
GLMAccumulator >> outerPortEvent: aPortEvent [ 
 	super outerPortEvent: aPortEvent.
	aPortEvent port name = #entityToSelect ifTrue: [
		self tryToSelectPaneFrom: aPortEvent port ].	
	aPortEvent port name = #entity ifTrue: [
		self addPaneFrom: aPortEvent port ]
]

{ #category : #private }
GLMAccumulator >> removePaneIndex: i [
	| paneRemoved |
	paneRemoved := self panes removeAt: i.
	self announce: (GLMPaneRemoved pane: paneRemoved fromBrowser: self )
]

{ #category : #rendering }
GLMAccumulator >> renderGlamorouslyOn: aRenderer [
	^ aRenderer renderAccumulator: self
]

{ #category : #private }
GLMAccumulator >> tryToSelectPaneFrom: aPort [
	self panes withIndexDo: [:each :i | 
		(each port: #entity) value = aPort value ifTrue: [
			self announce: 
				(GLMPaneSelected 
					pane: each 
					atPosition: i
					inBrowser: self).
			^ self ] ]
]
