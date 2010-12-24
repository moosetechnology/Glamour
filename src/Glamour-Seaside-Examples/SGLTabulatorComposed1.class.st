Class {
	#name : #SGLTabulatorComposed1,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorComposed1 class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/composed1'
]

{ #category : #accessing }
SGLTabulatorComposed1 >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser 
		column: [:c1| c1 row: #col1row1; row: #col1row2; row: #col1row3; row: #col1row4]; 
		column: [:c2| c2 row: #col2row1; row: #col2row2; row: #col2row3]; 
		column: [:c3| c3 
			row: [:r| r column: #col3row1col1; column: #col3row1col2; column: #col3row1col3 ]; 
			row: [:r| r column: #col3row2col1; column: #col3row2col2] ].
	
	^ browser
]

{ #category : #accessing }
SGLTabulatorComposed1 >> model [
	^ 1
]
