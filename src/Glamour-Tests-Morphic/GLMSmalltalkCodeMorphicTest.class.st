Class {
	#name : #GLMSmalltalkCodeMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMSmalltalkCodeMorphicTest >> testDefault [
	| browser textMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | a smalltalkCode display: '123456789'].
	window := browser openOn: 4.

	textMorph := window submorphs last submorphs first submorphs first.
	self assert: (textMorph isKindOf: GLMPluggableTextMorph)
]

{ #category : #tests }
GLMSmalltalkCodeMorphicTest >> testExplicitAcceptDoesNotAffectTextPort [
	| composite textMorph textPresentation |
	composite := GLMCompositePresentation new with: [ :a | a smalltalkCode display: '123' ].
	window := composite openOn: 4.
	textMorph := self find: PluggableTextMorph in: window.
	textMorph simulateClick.
	self simulateKeyStrokes: '4'.
	self assert: (composite pane port: #text) value = '1234'.
	self simulateKeyStroke: $s command.
	self simulateKeyStrokes: '56'.
	self assert: (composite pane port: #text) value = '123456'
]

{ #category : #tests }
GLMSmalltalkCodeMorphicTest >> testForSmalltalkWorkspace [
	| browser textMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | a smalltalkCode variableBindings: [:x | {#theNumber -> x}]].
	window := browser openOn: 42.

	textMorph := self find: GLMPluggableTextMorph in: window.
	self assert: (textMorph model hasBindingOf: #theNumber)
]
