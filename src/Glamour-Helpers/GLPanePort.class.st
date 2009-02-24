"
A port that belongs to a pane.

Bound ports have a few special characteristics in comparison to their superclass. For one, they don't just assign a value to themselves using #value: but rather generate a transmission that set the value so that the pane can handle the transmission and forward it to other ports if necessary, depending on the policy of the containing browser.
"
Class {
	#name : #GLPanePort,
	#superclass : #GLBoundPort,
	#instVars : [
		'pane',
		'value'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLPanePort >> pane [
	
	^pane
]

{ #category : #accessing }
GLPanePort >> pane: aPane [
	
	pane := aPane
]

{ #category : #accessing }
GLPanePort >> receive: aTransmission [
	
	| oldValue |
	oldValue := self value.
	self pane
		notingPresentationChangeDo:
			[value := aTransmission value.
			self pane
				portEvent:
					((GLPortEvent new)
						port: self;
						transmission: aTransmission;
						oldValue: oldValue;
						yourself)]
]

{ #category : #accessing }
GLPanePort >> value [
	
	^value
]

{ #category : #accessing }
GLPanePort >> value: anObject [
	
	(GLSimpleTransmission new)
		origin: (GLSimplePort new value: anObject);
		destination: self;
		transmit
]
