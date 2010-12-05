Class {
	#name : #SGLTabulatorWithTabs,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLTabulatorWithTabs class >> initialize [
	self registerAsApplication: 'glamour/development/tabulator/tabulatorWithTabs'
]

{ #category : #accessing }
SGLTabulatorWithTabs >> browser [
	"self new browser openOn: self new model"	
	| browser |
	browser := GLMTabulator new.
	browser row: [:r | 
		r column: #col1; column: #col2; column: #col3 ] span: 4; row: #preview.

	browser transmit  to: #col1; andShow: [ :a |
		"a title: 'A tab presentation."
		"a stackedVerticallyArrangement."
		a list
			title: 'First';
			showOnly: 50;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 80;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			showOnly: 70;
			display:  [ :x | 1 to: x ] .
		a list
			title: 'Fourth';			
			display:  [ :x | 1 to: x ] ].
		
	^browser
	
]

{ #category : #accessing }
SGLTabulatorWithTabs >> model [
	^ 50
]
