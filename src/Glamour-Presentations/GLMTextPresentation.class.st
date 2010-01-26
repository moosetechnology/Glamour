Class {
	#name : #GLMTextPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'selectedText',
		'cursorPosition',
		'selectedTextBlock',
		'highlightSmalltalk',
		'highlightSmalltalkContext',
		'textBlock',
		'text'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTextPresentation >> cursorPosition [ 
	 
	^cursorPosition
]

{ #category : #accessing }
GLMTextPresentation >> cursorPosition: anObject [ 
	 
	cursorPosition := anObject
]

{ #category : #accessing }
GLMTextPresentation >> forSmalltalk [
	highlightSmalltalk := true
]

{ #category : #accessing }
GLMTextPresentation >> forSmalltalk: aBlock [
	highlightSmalltalk := true.
	highlightSmalltalkContext := aBlock.
]

{ #category : #accessing }
GLMTextPresentation >> highlightSmalltalk [
	^ highlightSmalltalk ifNil: [highlightSmalltalk := false]
]

{ #category : #accessing }
GLMTextPresentation >> highlightSmalltalkContext [
	^ highlightSmalltalkContext isNil 
		ifTrue: [nil] 
		ifFalse: [highlightSmalltalkContext glamourValue: self entity]
]

{ #category : #rendering }
GLMTextPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderTextPresentation: self
]

{ #category : #accessing }
GLMTextPresentation >> selectedText [
	^ (self pane port: #selectedText) value isNil 
		ifTrue: [self selectedTextBlock value]
		ifFalse: [(self pane port: #selectedText) value]
]

{ #category : #accessing }
GLMTextPresentation >> selectedText: anObject [	 
	(self pane port: #selectedText) value: anObject copy
]

{ #category : #accessing }
GLMTextPresentation >> selectedTextBlock [
	^ selectedTextBlock ifNil: [ [''] ]
]

{ #category : #accessing }
GLMTextPresentation >> selectedTextBlock: anObject [
	selectedTextBlock := anObject
]

{ #category : #accessing }
GLMTextPresentation >> selectionInterval: anInterval [
	(self pane port: #selectionInterval) value: anInterval
]

{ #category : #accessing }
GLMTextPresentation >> text [
	^ (self pane port: #text) value isNil 
		ifTrue: [self textBlock value]
		ifFalse: [(self pane port: #text) value]
]

{ #category : #accessing }
GLMTextPresentation >> text: aString [
	(self pane port: #text) value: aString copy
]

{ #category : #accessing }
GLMTextPresentation >> textBlock [
	^ textBlock
]

{ #category : #accessing }
GLMTextPresentation >> textBlock: anObject [ 
	textBlock := anObject
]
