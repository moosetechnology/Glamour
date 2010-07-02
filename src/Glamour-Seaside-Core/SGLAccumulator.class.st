Class {
	#name : #SGLAccumulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'as yet unclassified' }
SGLAccumulator class >> initialize [
	self registerAsApplication: 'glamour/accumulator/composedAccumulator'
]

{ #category : #'as yet unclassified' }
SGLAccumulator >> browser [
	| browser acc |
	browser := GLMTabulator new.
	acc := GLMAccumulator new.
	acc show: [:a | 
		a title: [:x | x asString]. 
		a list title: 'List'; display: [:x | 1 to: x ].
		a text title: 'Text'; display: [:x | 'This is an editor on ', x printString ].
		].
	browser column: [:c | c row: #one span: 4; row: #two]; column: #three; column: #four.
	browser transmit to: #one; andShow: [:a | 
		a list display: [:x | x to: 10 * x]].
	browser transmit from: #one; to: #two; andShow: [:a |
		a text display: [:x | 'You have selected ', x printString, '. Double cick to open to the right']].
	browser transmit from: #one; to: #three; andShowIfNone: [:a |
		a custom: acc ].
	
	browser transmit from: #three; to: #four; andShow: [ :a |
		a list display: [:x| 1 to: x]	].

	^ browser
	
]

{ #category : #'as yet unclassified' }
SGLAccumulator >> model [
	^ 42
]
