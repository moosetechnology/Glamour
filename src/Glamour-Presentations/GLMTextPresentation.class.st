Class {
	#name : #GLMTextPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'text',
		'selectedText',
		'cursorPosition',
		'selectedTextBlock'
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
	 
	^text ifNil: [text := self formatedDisplayValue]
]

{ #category : #accessing }
GLMTextPresentation >> text: anObject [ 
	 
	text := anObject
]
