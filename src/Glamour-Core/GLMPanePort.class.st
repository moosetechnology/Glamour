"
A port that belongs to a pane.

Bound ports have a few special characteristics in comparison to their superclass. For one, they don't just assign a value to themselves using #value: but rather generate a transmission that set the value so that the pane can handle the transmission and forward it to other ports if necessary, depending on the policy of the containing browser.
"
Class {
	#name : #GLMPanePort,
	#superclass : #GLMBoundPort,
	#instVars : [
		'pane',
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPanePort >> pane [ 
	 
	^pane
]

{ #category : #accessing }
GLMPanePort >> pane: aPane [ 
	 
	pane _ aPane
]

{ #category : #accessing }
GLMPanePort >> receive: aTransmission [ 
	 
	| oldValue | 
	oldValue _ self value. 
	self pane 
		notingPresentationChangeDo: 
			[value _ aTransmission value. 
			self pane 
				portEvent: 
					((GLMPortEvent new) 
						port: self; 
						transmission: aTransmission; 
						oldValue: oldValue; 
						yourself)]
]

{ #category : #accessing }
GLMPanePort >> value [ 
	 
	^value
]

{ #category : #accessing }
GLMPanePort >> value: anObject [ 
	 
	(GLMSimpleTransmission new) 
		origin: (GLMSimplePort new value: anObject); 
		destination: self; 
		transmit
]
