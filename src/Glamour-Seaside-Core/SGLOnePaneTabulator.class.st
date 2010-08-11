Class {
	#name : #SGLOnePaneTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLOnePaneTabulator class >> initialize [
	self registerAsApplication: 'glamour/tabulator/onePaneWithoutPresentation'
]

{ #category : #accessing }
SGLOnePaneTabulator >> browser [
	"self new browser openOn: self new model"
	
	"| browser |
	browser := GLMTabulator new.
	browser row: #justARow.
	
	browser showOn: #justARow; using:[ browser list display: [:x | 1 to: x]; allowDeselection; beMultiple ].
	
	^browser"
	
| browser acc |
	browser := GLMTabulator new.

	browser row: #one; row: #two.
	browser transmit to: #one; andShow: [:a | 
		a list display: [:x | x to: 10 * x]; allowDeselection   ].
	browser transmit to: #two; andShow: [:a | 
		a list display: [:x | x to: 10 * x]  ].

	"browser transmit from: #one->#strongSelection; to: #two->#selection."
	
	browser transmit from: #one->#selection; to: #two->#selection.

	^ browser
]

{ #category : #accessing }
SGLOnePaneTabulator >> model [
	^ 10
]
