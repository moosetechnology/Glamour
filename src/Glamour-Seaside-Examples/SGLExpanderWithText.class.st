Class {
	#name : #SGLExpanderWithText,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLExpanderWithText class >> initialize [
	self registerAsApplication: 'glamour/development/expander/expanderWithText'
]

{ #category : #accessing }
SGLExpanderWithText >> browser [
	"self new browser openOn: self new model."
	| browser |
	
	browser := GLMExpander new.
	browser show: [ :a | 
		a title: [:x| x asString].
		a text ].
	^ browser
]

{ #category : #accessing }
SGLExpanderWithText >> model [
	^ #('
	a
	b
	c
	d
	e
	f
	g
	h
	j
	' 
	'aaaaaaaaa'
	'
	1
	2
	3
	4
	5
	6
	7
	8
	9
	')
]
