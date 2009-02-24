Class {
	#name : #GLParentPort,
	#superclass : #GLBoundPort,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Core'
}

{ #category : #comparing }
GLParentPort >> hash [
	
	^self port hash
]

{ #category : #accessing }
GLParentPort >> pane [
	
	^self presentation pane
]

{ #category : #accessing }
GLParentPort >> port [
	
	^self pane port: self name
]

{ #category : #accessing }
GLParentPort >> presentation [
	
	^presentation
]

{ #category : #accessing }
GLParentPort >> presentation: aPresentation [
	
	presentation := aPresentation
]

{ #category : #accessing }
GLParentPort >> receive: aTransmission [
	
	self port receive: aTransmission
]

{ #category : #accessing }
GLParentPort >> value [
	
	^self port value
]

{ #category : #accessing }
GLParentPort >> value: anObject [
	
	self port value: anObject
]
