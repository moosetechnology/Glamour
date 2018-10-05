Class {
	#name : #SGLTabulatorWithTable,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorWithTable class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/tabulatorWithTable'
]

{ #category : #accessing }
SGLTabulatorWithTable >> browser [
	"self new browser openOn: self new model"	
	| browser |
	browser := GLMTabulator new.
	browser row: #main.

	browser transmit to: #main; andShow: [ :a |
		a table
			display: [ :x | 1 to: x ]; 
			column: [:x | 'Numbers from 1 to ', x asString] evaluated: #asString;
			column: 'Even' evaluated: [ :each | each even asString ];
			column: 'Odd' evaluated: [ :each | each odd asString ]  ].
		
	^browser
	
]

{ #category : #accessing }
SGLTabulatorWithTable >> model [
	^ 200
]
