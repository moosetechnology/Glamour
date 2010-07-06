Class {
	#name : #SGLOnePaneTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLOnePaneTabulator class >> initialize [
	self registerAsApplication: 'glamour/tabulator/onePaneWithoutPresentation'
]

{ #category : #'as yet unclassified' }
SGLOnePaneTabulator >> browser [
	| browser |
	browser := GLMTabulator new.
	browser row: #justARow.
	
	browser showOn: #justARow; using:[ browser list display: [:x | 1 to: x]].
	
	^browser
]

{ #category : #'as yet unclassified' }
SGLOnePaneTabulator >> model [
	^ 100
]
