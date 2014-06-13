"
|browser|
browser := GLMTabulator new.
browser row: #r1; row: #r2.

browser transmit to: #r1; andShow: [ :aComposite |
	aComposite pharoMethod
		display: [ :method | method sourceCode ] ].
browser transmit to: #r2; andShow: [ :aComposite |
	aComposite pharoMethod
		display: [ :method | method sourceCode ] ;
		smalltalkClass: [ :method | method methodClass ] ].

browser openOn: (CompiledMethod class>>#gtExampleSimple) 



"
Class {
	#name : #GLMPharoMethodPresentation,
	#superclass : #GLMNewSmalltalkCodePresentation,
	#instVars : [
		'highlightSmalltalkContext'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #accessing }
GLMPharoMethodPresentation >> highlightSmalltalkContext [
	^ highlightSmalltalkContext isNil 
		ifTrue: [nil] 
		ifFalse: [highlightSmalltalkContext glamourValue: self entity]
]

{ #category : #rendering }
GLMPharoMethodPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderPharoMethodPresentation: self
]

{ #category : #accessing }
GLMPharoMethodPresentation >> smalltalkClass: aBlock [
	"aBlock takes as parameters the entity objects and 
	its evaluation is expected to produce a Smalltalk class"
	highlightSmalltalkContext := aBlock.
]