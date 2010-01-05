Class {
	#name : #GLMPresentationBoundPort,
	#superclass : #GLMBoundPort,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Core'
}

{ #category : #copying }
GLMPresentationBoundPort >> copyAccordingToPaneMapping: newPanesMapping inNewBrowser: anotherBrowser [
	^ self copy presentation: anotherBrowser
]

{ #category : #comparing }
GLMPresentationBoundPort >> hash [ 
	 
	^self port hash
]

{ #category : #accessing }
GLMPresentationBoundPort >> pane [ 
	 
	^self presentation pane
]

{ #category : #accessing }
GLMPresentationBoundPort >> port [ 
	 
	^self pane port: self name
]

{ #category : #accessing }
GLMPresentationBoundPort >> presentation [ 
	 
	^presentation
]

{ #category : #accessing }
GLMPresentationBoundPort >> presentation: aPresentation [ 
	 
	presentation := aPresentation
]

{ #category : #accessing }
GLMPresentationBoundPort >> receive: aTransmission in: aContext [
	self port receive: aTransmission in: aContext
	

]

{ #category : #accessing }
GLMPresentationBoundPort >> value [ 
	self flag: 'checking for #entity is rather not elegant, but it is a solution to not affect the other custom ports that will probably be desired to be populated in other ways.'.
	^ self name == #entity ifTrue: [
		(self presentation transformation glamourValue: self port value asGlamorousMultiValue)
	] ifFalse: [ self port value ]
]

{ #category : #accessing }
GLMPresentationBoundPort >> value: anObject in: aContext [
	(self validate: anObject) ifFalse: [^ self].
	self port value: anObject in: aContext
]
