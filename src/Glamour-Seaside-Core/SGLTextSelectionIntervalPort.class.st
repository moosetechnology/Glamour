Class {
	#name : #SGLTextSelectionIntervalPort,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTextSelectionIntervalPort class >> initialize [
	self registerAsApplication: 'glamour/text/selectionIntervalPorts'
]

{ #category : #accessing }
SGLTextSelectionIntervalPort >> browser [
	"self new browser openOn: self new model."

	| browser |
	browser := GLMTabulator new.
	browser 
		row: [ :r | 
			r 
			 column: #startInterval1; 
			 column: #startInterval2;
			column: [:c | 
				c row: [:r1 | r1 column: #changeSelection1; column: #changeSelection2]; 
				   row: [:r1 | r1 column: #changePresentation1; column: #changePresentation2] ] ]; 
		row: [:r | r column: #text; column: #details].
	browser transmit to: #startInterval1; andShow: [ :a | a list title: 'Set start of selection interval' ].
	browser transmit to: #startInterval2; andShow: [ :a | a list title: 'Set end of selection interval' ].
	
	browser transmit 
		to: #text->#selectionInterval; 
		from: #startInterval1; 
		from: #startInterval2; 
		when: [:s :e | s notNil & e notNil] ; 
		transformed: [ :s :e | s to: e ].
	
	browser transmit to: #changeSelection1; andShow: [ :a | a list title: 'Sets selection to start of selection interval' ].
	browser transmit to: #changeSelection2; andShow: [ :a | a list title: 'Sets selection to end of selection interval' ].
	
	browser transmit 
		to: #changePresentation1; 
		from: #text->#selectionInterval; 
		transformed: [:interval | interval first];
		andShow: [ :a | 
			a list 
				title: 'List to start of selection interval';
				display: [:x | 1 to: x] ].
	browser transmit 
		to: #changePresentation2; 
		from: #text->#selectionInterval; 
		transformed: [:interval | interval last];
		andShow: [ :a | 
			a list 
				title: 'List to end of selection interval';
				display: [:x | 1 to: x] ].
	
	browser transmit to: #changeSelection1->#selection; from: #text->#selectionInterval; transformed: [:interval | interval first].
	browser transmit to: #changeSelection2->#selection; from: #text->#selectionInterval; transformed: [:interval | interval last].
	
	browser transmit to: #text; andShow: [ :a | 
		a text 
			title: 'Text with selection';
			display: 'some piece of text to test the selection interval on.'].

	"browser showOn: #details; from: #text->#selectedText; using: [browser text]."
	"browser transmit 
		to: #details; 
		from: #text->#text;
		from: #text->#selectionInterval;
		from: #text->#selectedText; 
		when: [:text :interval :selection | true] ;
		transformed:  [ :text :interval  :selection |
			'Text: ',text asString, '
Selection: ', selection asString,'
Interval: ', interval asString  ];
		andShow: [ :a| a text]."
	browser transmit 
		to: #details; 
		from: #text->#selectedText; 
		when: [:selection | true] ;
		transformed:  [ :selection |
			'Selection: ', selection asString ];
		andShow: [ :a| a text].
	
	
	^ browser 
]

{ #category : #accessing }
SGLTextSelectionIntervalPort >> model [
	^ 1 to: 100
]
