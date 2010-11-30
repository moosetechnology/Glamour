Class {
	#name : #SGLTabulatorWithinTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTabulatorWithinTabulator class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/tabulatorWithinTabulator1'
]

{ #category : #accessing }
SGLTabulatorWithinTabulator >> browser [
	"self new browser openOn: self new model"
	|browser1 browser2 browser3|
	browser1 := GLMTabulator new.
	browser1 
		column: #col1; 
		column: #col2.
		
	browser2 := GLMTabulator new.
	browser2 
		row: #row1; 
		row: #row2.
		
	browser3 := GLMTabulator new.
	browser3 
		row: #row1; 
		row: #row2;
		row: #row3.
	
	browser1 transmit to: #col1; andShow: [:a|
		a custom: browser2 ].
	browser1 transmit to: #col2; andShow: [:a|
		a custom: browser3 ].
	
	^ browser1
]

{ #category : #accessing }
SGLTabulatorWithinTabulator >> model [
	^ 1
]
