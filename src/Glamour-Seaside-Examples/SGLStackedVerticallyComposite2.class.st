Class {
	#name : #SGLStackedVerticallyComposite2,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #initialization }
SGLStackedVerticallyComposite2 class >> initialize [
	self registerAsApplication: 'glamour/development/stack/dynamicCreation'
]

{ #category : #accessing }
SGLStackedVerticallyComposite2 >> browser [	
	| browser innerBrowser1 |
	
	innerBrowser1 := GLMTabulator new.
	innerBrowser1 column: #col1; column: #col2 span: 3.
	innerBrowser1 title: 'Inner browser 1'.
	innerBrowser1 transmit to: #col1; andShow: [:a|
		a list display: [:x| 1 to: x]].
	innerBrowser1 transmit to: #col2; andShow: [:a|
		a stackedVerticallyArrangement.
		a list 
			title: 'Inner list 1';
			display: [:x| 1 to: x].
		a list 
			title: 'Inner list 2';
			display: [:x| 1 to: x] ].
	
	browser := GLMTabulator new.
	browser column: #list; column: #stack span: 5.
	
	browser transmit to: #list; andShow: [:a|
		a list].
	
	browser transmit to: #stack; from: #list; andShow: [:a | 
		a title: 'Stack'.
		a stackedVerticallyArrangement.
		a list 
			title: 'List1';
			display: [:x| 1 to: x]. 
		a  custom: innerBrowser1 ].

	^ browser 
]

{ #category : #accessing }
SGLStackedVerticallyComposite2 >> model [
	^ 1 to: 20
]
