Class {
	#name : #SGLTabulatorFourRows,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTabulatorFourRows class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/fourRows'
]

{ #category : #accessing }
SGLTabulatorFourRows >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser row: #one; row: #two; row: #three; row: #four.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorFourRows >> model [
	^ nil
]
