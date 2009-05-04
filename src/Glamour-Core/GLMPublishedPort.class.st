Class {
	#name : #GLMPublishedPort,
	#superclass : #Object,
	#instVars : [
		'outerPortName',
		'innerPort'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMPublishedPort >> innerPort [ 
	 
	^innerPort
]

{ #category : #accessing }
GLMPublishedPort >> innerPort: aPort [ 
	 
	innerPort _ aPort
]

{ #category : #accessing }
GLMPublishedPort >> outerPortName [ 
	 
	^outerPortName
]

{ #category : #accessing }
GLMPublishedPort >> outerPortName: aSymbol [ 
	 
	outerPortName _ aSymbol
]
