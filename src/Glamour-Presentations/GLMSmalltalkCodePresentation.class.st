Class {
	#name : #GLMSmalltalkCodePresentation,
	#superclass : #GLMTextualPresentation,
	#instVars : [
		'highlightSmalltalkContext',
		'variableBindingsBlock'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #accessing }
GLMSmalltalkCodePresentation >> highlightSmalltalkContext [
	^ highlightSmalltalkContext isNil 
		ifTrue: [nil] 
		ifFalse: [highlightSmalltalkContext glamourValue: self entity]
]

{ #category : #rendering }
GLMSmalltalkCodePresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSmalltalkCodePresentation: self
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> smalltalkClass: aBlock [
	"aBlock takes as parameters the entity objects and 
	its evaluation is expected to produce a Smalltalk class"
	highlightSmalltalkContext := aBlock.
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> updateVariableBindings [

	self announce: (GLMVariableBindingsChanged new presentation: self).
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> variableBindings [
	^ (variableBindingsBlock glamourValue: self entity) ifNil: [OrderedCollection new]
]

{ #category : #accessing }
GLMSmalltalkCodePresentation >> variableBindings: aBlock [
	^ variableBindingsBlock := aBlock
]
