Class {
	#name : #SGLTabulatorOneColumn,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorOneColumn class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/oneColumn'
]

{ #category : #accessing }
SGLTabulatorOneColumn >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser column: #one span: 2.
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorOneColumn >> model [
	^ nil
]
