Class {
	#name : #SGLTabulatorOneRow,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTabulatorOneRow class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/oneRow'
]

{ #category : #accessing }
SGLTabulatorOneRow >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser row: #one span: 5.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorOneRow >> model [
	^ nil
]
