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
	 
	^aRenderer renderTextPresentation: self
]

{ #category : #accessing }
GLMTextPresentation >> selectedText [
	^ selectedText isNil 
		ifTrue: [self selectedTextBlock value]
		ifFalse: [selectedText]
]

{ #category : #accessing }
GLMTextPresentation >> selectedText: anObject [
	selectedText := anObject
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
GLMTextPresentation >> selection [ 
	 
	^selectedText
]

{ #category : #accessing }
GLMTextPresentation >> text [
	^ text isNil 
		ifTrue: [self textBlock value]
		ifFalse: [text]
]

{ #category : #accessing }
GLMTextPresentation >> textBlock [
	^ textBlock
]

{ #category : #accessing }
GLMTextPresentation >> textBlock: anObject [ 
	textBlock := anObject
]
