Class {
	#name : #GLPublishedPort,
	#superclass : #Object,
	#instVars : [
		'outerPortName',
		'innerPort'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLPublishedPort >> innerPort [
	
	^innerPort
]

{ #category : #accessing }
GLPublishedPort >> innerPort: aPort [
	
	innerPort := aPort
]

{ #category : #accessing }
GLPublishedPort >> outerPortName [
	
	^outerPortName
]

{ #category : #accessing }
GLPublishedPort >> outerPortName: aSymbol [
	
	outerPortName := aSymbol
]
