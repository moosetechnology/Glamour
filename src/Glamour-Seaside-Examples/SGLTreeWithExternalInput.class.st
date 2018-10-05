Class {
	#name : #SGLTreeWithExternalInput,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLTreeWithExternalInput class >> initialize [
	self registerAsApplication: 'glamour/development/tree/treeWithExternalInput'
]

{ #category : #accessing }
SGLTreeWithExternalInput >> browser [
	|browser|

	browser := GLMTabulator new.
	browser  row: #tree.

	browser transmit to: #tree;  transformed: [:value| value asInteger]; andShow: [ :a |
		a list 
			display:  [ :x | 1 to: x ] ].
		
	browser transmit fromOutsidePort: #externalSelection; to: #tree port: #selection; transformed: [:value| value asInteger].
	
	^browser
]

{ #category : #accessing }
SGLTreeWithExternalInput >> model [
	^ 20
]
