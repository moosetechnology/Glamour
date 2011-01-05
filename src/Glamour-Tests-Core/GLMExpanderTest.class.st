Class {
	#name : #GLMExpanderTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMExpanderTest >> testCreation [
	self assert: GLMExpander new panes isEmpty
]

{ #category : #tests }
GLMExpanderTest >> testDisplay [
	| expander |
	expander := GLMExpander new.
	expander display: [:number | (1 to: number) collect: #asString].
	expander show: [:a | a text ].
	expander startOn: 3.
	self assert: expander panes size = 3.
	self assert: expander panes first presentations entity value = '1'.
	self assert: expander panes first presentations size = 1.
	self assert: (expander panes first presentations first isKindOf: GLMTextPresentation)
]

{ #category : #tests }
GLMExpanderTest >> testPresentations [
	| expander |
	expander := GLMExpander new.
	expander show: [:a | a text ].
	expander startOn: #(a b c).
	self assert: expander panes size = 3.
	self assert: expander panes first presentations entity value = #a.
	self assert: expander panes first presentations size = 1.
	self assert: (expander panes first presentations first isKindOf: GLMTextPresentation)
]

{ #category : #tests }
GLMExpanderTest >> testSimple [
	| expander |
	expander := GLMExpander new.
	expander startOn: #(a b c).
	self assert: expander panes size = 3.
	self assert: (expander panes first port: #entity) value = #a
]
