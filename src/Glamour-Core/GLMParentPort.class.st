Class {
	#name : #GLMParentPort,
	#superclass : #GLMBoundPort,
	#instVars : [
		'presentation'
	],
	#category : #'Glamour-Core'
}

{ #category : #comparing }
GLMParentPort >> hash [ 
	 
	^self port hash
]

{ #category : #accessing }
GLMParentPort >> pane [ 
	 
	^self presentation pane
]

{ #category : #accessing }
GLMParentPort >> port [ 
	 
	^self pane port: self name
]

{ #category : #accessing }
GLMParentPort >> presentation [ 
	 
	^presentation
]

{ #category : #accessing }
GLMParentPort >> presentation: aPresentation [ 
	 
	presentation _ aPresentation
]

{ #category : #accessing }
GLMParentPort >> receive: aTransmission [ 
	 
	self port receive: aTransmission
]

{ #category : #accessing }
GLMParentPort >> value [ 
	 
	^self port value
]

{ #category : #accessing }
GLMParentPort >> value: anObject [ 
	 
	self port value: anObject
]
