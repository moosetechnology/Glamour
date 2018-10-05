Class {
	#name : #SGLTreeAppend,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTreeAppend class >> initialize [
	self registerAsApplication: 'glamour/development/tree/treeWithAppend'
]

{ #category : #accessing }
SGLTreeAppend >> browser [
	|browser|

	browser := GLMTabulator new.
	browser  column: #col1; column: #col2; column: #col3; column: #col4.

	browser transmit  to: #col1; andShow: [ :a |
		a list
			title: 'First';
			showOnly: 10;
			display:  [ :x | 1 to: x ] ].
	browser transmit  to: #col2; andShow: [ :a |		
		a list
			title: 'Second';
			showOnly: 20;
			display:  [ :x | 1 to: x ] ].
		
	browser transmit  to: #col3; andShow: [ :a |		
		a list
			title: 'Third';
			showOnly: 70;
			display:  [ :x | 1 to: x ]  ].
		
	browser transmit  to: #col4; andShow: [ :a |		
		a list
			title: 'Fourth';
			showOnly: 524;
			display:  [ :x | 1 to: x ] ].
	
	^browser
]

{ #category : #accessing }
SGLTreeAppend >> model [
	^ 100
]
