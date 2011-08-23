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
	"Returns the object that should be used when evaluating 'self' within the presentation. 'nil' is the default value"
	^ doItReceiver glamourValue: self entity
]

{ #category : #accessing }
GLMTextualPresentation >> doItReceiver: aOneArgBlock [
	"The block will be passed the current entity and is expected to return an object .This object will then be returned upon evaluation of 'self' within the presentation."
	doItReceiver := aOneArgBlock
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
