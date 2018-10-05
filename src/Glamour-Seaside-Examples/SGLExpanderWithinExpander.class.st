Class {
	#name : #SGLExpanderWithinExpander,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLExpanderWithinExpander class >> initialize [
	self registerAsApplication: 'glamour/development/expander/expanderWithinExpander'
]

{ #category : #accessing }
SGLExpanderWithinExpander >> browser [
	"self new browser openOn: self new model."
	| browser |
	
	browser := GLMExpander new.
	browser show: [ :a | 
		|expander|
		
		a title: [:x | x asString].
		expander := GLMExpander new.
		expander show: [ :aa |
			aa title: [:x | x asString].
			aa list
				display: [:x| 1 to: x] ].
		
		a custom: expander ].
	^ browser
]

{ #category : #accessing }
SGLExpanderWithinExpander >> model [
	^ #( #(2 5) #(12 14) #(3 4) )
]
