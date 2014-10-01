"
I provide support for displaying snippets of Smalltalk code  (e.g. dealing with variable binding)

self pharoPlaygroundPresentationExample
"
Class {
	#name : #GLMPharoPlaygroundPresentation,
	#superclass : #GLMNewSmalltalkCodePresentation,
	#instVars : [
		'variableBindingsBlock'
	],
	#category : #'Glamour-Rubric-Presentations'
}

{ #category : #examples }
GLMPharoPlaygroundPresentation class >> pharoPlaygroundPresentationExample [
	"
	self pharoPlaygroundPresentationExample
	"
	| browser |
	browser := GLMTabulator new.
	browser
		row: #r1;
		row: #r2.
	browser transmit
		to: #r1;
		andShow: [ :aComposite | 
					aComposite pharoPlayground
						selectionAct: [ :workspace :page | workspace evaluateSelection ] on: $d entitled: 'Do it';
						selectionAct: [ :workspace :page | workspace evaluateSelectionAndDo: [ :result | result inspect ] ]
							on: $i
							entitled: 'Inspect it';
						selectionAct: [ :workspace :page | workspace evaluateSelectionAndDo: [ :result | result explore ] ]
							on: $e
							entitled: 'Explore it' ].
	browser transmit
		to: #r2;
		andShow: [ :aComposite | 
					aComposite pharoPlayground
						variableBindings: [ 
							{(#browser -> browser).
							(#a -> 1)} ] ].
	browser
		openOn:
			'browser := GLMTabulator new.
browser row: #r1; row: #r2.

browser transmit to: #r1; andShow: [ :aComposite |
	aComposite pharoPlayground].
browser openOn:''self halt'' '
]

{ #category : #rendering }
GLMPharoPlaygroundPresentation >> renderGlamorouslyOn: aRenderer [ 
	self registerAnnouncements.
	^ aRenderer renderPharoPlaygroundPresentation: self
]

{ #category : #actions }
GLMPharoPlaygroundPresentation >> updateVariableBindings [

	self announce: (GLMVariableBindingsChanged new presentation: self).
]

{ #category : #accessing }
GLMPharoPlaygroundPresentation >> variableBindings [
	^ (variableBindingsBlock glamourValue: self entity) ifNil: [OrderedCollection new]
]

{ #category : #accessing }
GLMPharoPlaygroundPresentation >> variableBindings: aBlock [
	^ variableBindingsBlock := aBlock
]
