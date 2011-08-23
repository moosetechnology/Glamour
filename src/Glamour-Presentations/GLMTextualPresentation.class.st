Class {
	#name : #GLMTextualPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'selectedText',
		'cursorPosition',
		'text',
		'doItReceiver'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #'accessing ports' }
GLMTextualPresentation >> cursorPosition [ 
	 
	^cursorPosition
]

{ #category : #'accessing ports' }
GLMTextualPresentation >> cursorPosition: anObject [ 
	 
	cursorPosition := anObject
]

{ #category : #accessing }
GLMTextualPresentation >> doItReceiver [
	^ (doItReceiver ifNil: [doItReceiver := #yourself])
		glamourValue: self entity
]

{ #category : #accessing }
GLMTextualPresentation >> doItReceiver: anObject [
	doItReceiver := anObject
]

{ #category : #'accessing ports' }
GLMTextualPresentation >> selectedText [
	^ (self pane port: #selectedText) value isNil 
		ifTrue: [self selectedTextBlock value]
		ifFalse: [(self pane port: #selectedText) value]
]

{ #category : #'accessing ports' }
GLMTextualPresentation >> selectedText: anObject [
	(self pane port: #selectedText) value: anObject copy
]

{ #category : #'accessing ports' }
GLMTextualPresentation >> text [
	^ (self pane port: #text) value isNil 
		ifTrue: [self textBlock value]
		ifFalse: [(self pane port: #text) value]
]

{ #category : #'accessing ports' }
GLMTextualPresentation >> text: aString [
	(self pane port: #text) value: aString copy
]
