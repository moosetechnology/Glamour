Class {
	#name : #SGLExpanderWithLists,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLExpanderWithLists class >> initialize [
	self registerAsApplication: 'glamour/development/expander/expanderWithLists'
]

{ #category : #accessing }
SGLExpanderWithLists >> browser [
	"self new browser openOn: self new model."
	| browser |
	
	browser := GLMExpander new.
	browser title: 'An expander'.
	browser show: [ :a | 
		a title: [:x| x asString].
		a list
			display: [:x | 1 to: x] ].
	^ browser
]

{ #category : #accessing }
SGLExpanderWithLists >> model [
	^ #(1 2 3 4 6 7 8 9 1000 2001)
]
