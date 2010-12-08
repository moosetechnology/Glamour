Class {
	#name : #SGLTabulatorTwoRows,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorTwoRows class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/twoRows'
]

{ #category : #accessing }
SGLTabulatorTwoRows >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser row: #one span: 1; row: #two span: 3.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorTwoRows >> model [
	^ nil
]
