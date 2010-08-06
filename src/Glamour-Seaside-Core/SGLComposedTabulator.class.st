Class {
	#name : #SGLComposedTabulator,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLComposedTabulator class >> initialize [
	self registerAsApplication: 'glamour/tabulator/composedTabulator'
]

{ #category : #accessing }
SGLComposedTabulator >> browser [
		|browser|

	browser := GLMTabulator new.
	browser column:  #tab; column: #accordion; column: #stack.

	browser transmit  to: #tab; andShow: [ :a |
		a title: 'Tab arrangement'.
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
			display:  [ :x | 1 to: x ] ].

	browser transmit  to: #accordion; andShow: [ :a |
		a accordionArrangement.
		a title: 'Accordion arrangement'.
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
			display:  [ :x | 1 to: x ] ].
		
	browser transmit  to: #stack; andShow: [ :a |
		a stackedVerticallyArrangement.
		a title: 'Stack arrangment'.
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
			display:  [ :x | 1 to: x ] ].
		
	^browser 
]

{ #category : #accessing }
SGLComposedTabulator >> model [
	^ 1000

]
