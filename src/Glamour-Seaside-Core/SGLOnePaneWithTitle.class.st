Class {
	#name : #SGLOnePaneWithTitle,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLOnePaneWithTitle class >> initialize [
	self registerAsApplication: 'glamour/tabulator/onePaneWithTitle'
]

{ #category : #accessing }
SGLOnePaneWithTitle >> browser [
	|browser|
	
	browser := GLMTabulator new.
	browser row: #justARow.
	browser title: 'Tabulator'.
	
	browser transmit to: #justARow; andShow: [ :a |
		a list
			showOnly: 20;
			title: 'A list presentation';
			display:  [ :x | 1 to: x ] ].
	
	
	^browser 
	

]

{ #category : #accessing }
SGLOnePaneWithTitle >> model [
	^ 100
]
