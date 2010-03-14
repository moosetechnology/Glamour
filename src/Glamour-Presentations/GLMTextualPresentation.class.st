Class {
	#name : #GLMTextualPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'selectedText',
		'cursorPosition',
		'text'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTextualPresentation >> cursorPosition [ 
	 
	^cursorPosition
]

{ #category : #accessing }
GLMTextualPresentation >> cursorPosition: anObject [ 
	 
	cursorPosition := anObject
]

{ #category : #accessing }
GLMTextualPresentation >> selectedText [
	^ (self pane port: #selectedText) value isNil 
		ifTrue: [self selectedTextBlock value]
		ifFalse: [(self pane port: #selectedText) value]
]

{ #category : #accessing }
GLMTextualPresentation >> selectedText: anObject [	 
	(self pane port: #selectedText) value: anObject copy
]

{ #category : #accessing }
GLMTextualPresentation >> text [
	^ (self pane port: #text) value isNil 
		ifTrue: [self textBlock value]
		ifFalse: [(self pane port: #text) value]
]

{ #category : #accessing }
GLMTextualPresentation >> text: aString [
	(self pane port: #text) value: aString copy
]
