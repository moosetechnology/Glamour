Class {
	#name : #SGLStackedVerticallyComposite1,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLStackedVerticallyComposite1 class >> initialize [
	self registerAsApplication: 'glamour/development/stack/threePanes'
]

{ #category : #accessing }
SGLStackedVerticallyComposite1 >> browser [	
	| browser |
	browser := GLMTabulator new.
	browser row: #aRow.
	
	browser transmit to: #aRow; andShow: [:a | 
		a title: 'Stack'.
		a stackedVerticallyArrangement.
		a list 
			title: 'List1';
			display: [:x| 1 to: x]. 
		a list 
			title: 'List2';
			display: [:x| 1 to: x-1].
		a list 
			title: 'List3';
			display: [:x| 10 to: x] ].

	^ browser 
]

{ #category : #accessing }
SGLStackedVerticallyComposite1 >> model [
	^ 20
]
