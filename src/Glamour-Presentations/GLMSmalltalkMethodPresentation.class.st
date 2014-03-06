"
browser := GLMTabulator new.
browser row: #r1; row: #r2; row: #r3.

browser transmit to: #r1; andShow: [ :aComposite |
	aComposite smalltalkMethod
		display: [ :method | method sourceCode ] ].
browser transmit to: #r2; andShow: [ :aComposite |
	aComposite smalltalkMethod
		display: [ :method | method sourceCode ] ;
		smalltalkClass: [ :method | method methodClass ] ].

browser openOn: (CompiledMethod class>>#gtExampleSimple) 



"
Class {
	#name : #GLMSmalltalkMethodPresentation,
	#superclass : #GLMNewSmalltalkCodePresentation,
	#instVars : [
		'highlightSmalltalkContext'
	],
	#category : #'Glamour-Presentations'
}

{ #category : #'as yet unclassified' }
GLMSmalltalkMethodPresentation >> highlightSmalltalkContext [
	^ highlightSmalltalkContext isNil 
		ifTrue: [nil] 
		ifFalse: [highlightSmalltalkContext glamourValue: self entity]
]

{ #category : #'as yet unclassified' }
GLMSmalltalkMethodPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderSmalltalkMethodPresentation: self
]

{ #category : #'as yet unclassified' }
GLMSmalltalkMethodPresentation >> smalltalkClass: aBlock [
	"aBlock takes as parameters the entity objects and 
	its evaluation is expected to produce a Smalltalk class"
	highlightSmalltalkContext := aBlock.
]
