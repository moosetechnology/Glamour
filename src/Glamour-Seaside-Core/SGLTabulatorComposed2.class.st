Class {
	#name : #SGLTabulatorComposed2,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorComposed2 class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/composed2'
]

{ #category : #accessing }
SGLTabulatorComposed2 >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser 
		column: [:c1| c1 row: [:r|
				r column: #col1row1col1; column: #col1row1col2; column: #col1row1col2 ]; 
			row: #col1row2; row: #col1row3]; 
		column: [:c2| c2 row: #col2row1; row: [ :c |
				c column: #a; column: #b ]].
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorComposed2 >> model [
	^ nil
]
