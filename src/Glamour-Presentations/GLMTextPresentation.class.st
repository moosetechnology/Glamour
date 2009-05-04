Class {
	#name : #GLMTextPresentation,
	#superclass : #GLMFormatedPresentation,
	#instVars : [
		'text',
		'selectedText',
		'cursorPosition'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTextPresentation >> cursorPosition [ 
	 
	^cursorPosition
]

{ #category : #accessing }
GLMTextPresentation >> cursorPosition: anObject [ 
	 
	cursorPosition _ anObject
]

{ #category : #rendering }
GLMTextPresentation >> renderGlamorouslyOn: aRenderer [ 
	 
	^aRenderer renderTextPresentation: self
]

{ #category : #accessing }
GLMTextPresentation >> selectedText [ 
	 
	^selectedText
]

{ #category : #accessing }
GLMTextPresentation >> selectedText: anObject [ 
	 
	selectedText _ anObject
]

{ #category : #accessing }
GLMTextPresentation >> text [ 
	 
	^text ifNil: [text _ self formatedDisplayValue]
]

{ #category : #accessing }
GLMTextPresentation >> text: anObject [ 
	 
	text _ anObject
]
