Class {
	#name : #SGLTreeSelectionOutsideLimits,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTreeSelectionOutsideLimits class >> initialize [
	self registerAsApplication: 'glamour/development/tree/treeWithSelectionOutsideLimits'
]

{ #category : #accessing }
SGLTreeSelectionOutsideLimits >> browser [
	"self new browser openOn: self new model"
	|browser|

	browser := GLMTabulator new.
	browser  
		column: #col1; 
		column: [:c | 
			c row: [:r | r column: #col2_row1_col1; column: #col2_row1_col2 ]; row: #col2_row2 ].

	browser transmit  to: #col1; andShow: [ :a |
		a list				
			display:  [ :x | 4*x to: 20*x ] ].
		
	browser transmit  to: #col2_row2; from: #col1->#selection; andShow: [ :a |
		a text].
	
	browser transmit  to: #col2_row1_col1; andShow: [ :a |
		a list					
			showOnly: 40;
			display:  [ :x | 1 to: x * 20 ] ].
	
	browser transmit  to: #col2_row1_col1->#selection; from: #col1->#selection.
	
	browser transmit  to: #col2_row1_col2; from: #col2_row1_col1->#selection; andShow: [ :a |
		a text ].
	
	^browser
]

{ #category : #accessing }
SGLTreeSelectionOutsideLimits >> model [
	^ 10
]
