Class {
	#name : #SGLTabulatorTwoColumns,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'as yet unclassified' }
SGLTabulatorTwoColumns class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/twoColumns'
]

{ #category : #accessing }
SGLTabulatorTwoColumns >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser column: #one span: 1; column: #two span: 1.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorTwoColumns >> model [
	^ nil
]
