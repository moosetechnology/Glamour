Class {
	#name : #SGLExpanderWithAdd,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLExpanderWithAdd class >> initialize [
	self registerAsApplication: 'glamour/development/expander/expanderWithAdd'
]

{ #category : #accessing }
SGLExpanderWithAdd >> browser [
	"self new browser openOn: self new model."
	| browser expander |
	
	expander := GLMExpander new.
	expander title: 'An expander'.
	expander show: [ :a | 
		a title: [:x| x asString].
		a list
			display: [:x | 1 to: x]].
	
	browser := GLMTabulator new.
	browser column: #col1; column: #col2.
	browser transmit to: #col1; andShow: [ :a |
		a list
			display: [ :x | 1to: x] ].
	browser transmit from: #col1->#selection transformed: [:value| value to: value]; to: #col2; andShowIfNone: [:a |
		a custom: expander ].
		
	^ browser
]

{ #category : #accessing }
SGLExpanderWithAdd >> model [
	^ 100
]
