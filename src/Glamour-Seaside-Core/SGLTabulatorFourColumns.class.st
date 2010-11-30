Class {
	#name : #SGLTabulatorFourColumns,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTabulatorFourColumns class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/fourColumns'
]

{ #category : #accessing }
SGLTabulatorFourColumns >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three; column: #four.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorFourColumns >> model [
	^ nil
]
