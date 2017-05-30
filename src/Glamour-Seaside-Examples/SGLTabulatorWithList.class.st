Class {
	#name : #SGLTabulatorWithList,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTabulatorWithList class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/tabulatorWithList'
]

{ #category : #accessing }
SGLTabulatorWithList >> browser [
	"self new browser openOn: self new model"	
	| browser |
	browser := GLMTabulator new.
	browser row: #main.

	browser transmit to: #main; andShow: [ :a |
		a list
			display: [ :x | 1 to: x ]  ].
		
	^browser
	
]

{ #category : #accessing }
SGLTabulatorWithList >> model [
	^ 142
]
