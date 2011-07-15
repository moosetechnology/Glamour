"
A presentation displaying text.

Instance Variables:
	selectedTextBlock	<ProtoObject>
	highlightSmalltalk	<Boolean>
	highlightSmalltalkContext	<Object>
	textBlock	<ProtoObject | PseudoContext>
"
Class {
	#name : #GLMTextPresentation,
	#superclass : #GLMTextualPresentation,
	#instVars : [
		'selectedTextBlock',
		'highlightSmalltalk',
		'highlightSmalltalkContext',
		'textBlock',
		'variableBindingsBlock'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMTextPresentation >> forSmalltalk [
	highlightSmalltalk := true
]

{ #category : #accessing }
GLMTextPresentation >> forSmalltalk: aBlock [
	"aBlock takes as parameters the entity objects and 
	its evaluation is expected to produce a Smalltalk class"
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
GLMTextPresentation >> selectedTextBlock [
	^ selectedTextBlock ifNil: [ [''] ]
]

{ #category : #accessing }
GLMTextPresentation >> selectedTextBlock: anObject [
	selectedTextBlock := anObject
]

{ #category : #accessing }
GLMTextPresentation >> selectionInterval [
	^ (self pane port: #selectionInterval) value
]

{ #category : #accessing }
GLMTextPresentation >> selectionInterval: anInterval [
	(self pane port: #selectionInterval) value: anInterval
]

{ #category : #accessing }
GLMTextPresentation >> textBlock [
	^ textBlock
]

{ #category : #accessing }
GLMTextPresentation >> textBlock: anObject [ 
	textBlock := anObject
]

{ #category : #accessing }
GLMTextPresentation >> variableBindings [
	^ (variableBindingsBlock glamourValue: self entity) ifNil: [OrderedCollection new]
]

{ #category : #accessing }
GLMTextPresentation >> variableBindings: aBlock [
	^ variableBindingsBlock := aBlock
]
