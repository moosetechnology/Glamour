Class {
	#name : #SGLOnePaneMultipleTabPresentations,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLOnePaneMultipleTabPresentations class >> initialize [
	self registerAsApplication: 'glamour/tabulator/onePaneWithMultipleTabs'
]

{ #category : #accessing }
SGLOnePaneMultipleTabPresentations >> browser [
	|browser|

	browser := GLMTabulator new.
	browser row: #justARow.

	browser transmit  to: #justARow; andShow: [ :a |
		"a title: 'A tab presentation."
		"a stackedVerticallyArrangement."
		a list
			title: 'First';
			showOnly: 10;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			showOnly: 300;
			display:  [ :x | 1 to: x ] .
		a list
			title: 'Fourth';
			showOnly: 524;
			display:  [ :x | 1 to: x ] .
		a list
			title: 'Fifth';
			display:  [ :x | 1 to: x ] ].
		
	^browser 
]

{ #category : #accessing }
SGLOnePaneMultipleTabPresentations >> model [
	^ 1000
]
