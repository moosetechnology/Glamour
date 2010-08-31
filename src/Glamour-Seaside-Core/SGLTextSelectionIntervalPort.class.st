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
	browser transmit to: #startInterval1; andShow: [ :a | a list title: 'Set start of selection interval'; allowDeselection ].
	browser transmit to: #startInterval2; andShow: [ :a | a list title: 'Set end of selection interval'; allowDeselection ].
	
	browser transmit 
		to: #text->#selectionInterval; 
		from: #startInterval1; 
		from: #startInterval2; 
		when: [:s :e | (s notNil & e notNil) or: [s isNil & e isNil] ] ; 
		transformed: [ :s :e |  (s isNil & e isNil) ifTrue: [nil] ifFalse:  [s to: e] ].
	
	browser transmit to: #changeSelection1; andShow: [ :a | a list title: 'Sets selection to start of selection interval'; allowDeselection  ].
	browser transmit to: #changeSelection2; andShow: [ :a | a list title: 'Sets selection to end of selection interval'; allowDeselection  ].
	browser transmit to: #changeSelection1->#selection; from: #text->#selectionInterval; transformed: [:interval | interval ifNil: [nil] ifNotNil: [interval first] ].
	browser transmit to: #changeSelection2->#selection; from: #text->#selectionInterval; transformed: [:interval | interval ifNil: [nil] ifNotNil: [interval last] ].
	
	browser transmit 
		to: #changePresentation1; 
		from: #text->#selectionInterval; 
		transformed: [:interval | interval ifNil: [0] ifNotNil: [interval first] ];
		andShow: [ :a | 
			a list 
				title: 'List to start of selection interval';
				display: [:x | 0 to: x] ].
	browser transmit 
		to: #changePresentation2; 
		from: #text->#selectionInterval; 
		transformed: [:interval | interval ifNil: [0] ifNotNil: [interval last] ];
		andShow: [ :a | 
			a list 
				title: 'List to end of selection interval';
				display: [:x | 0 to: x] ].
	
	browser transmit to: #text; andShow: [ :a | 
		a text 
			title: 'Text with selection';
			"display: 'some piece of text to test the selection interval on.']."
			display: '123456789'].
		
	browser transmit 
		to: #details; 
		from: #text->#text;
		from: #text->#selectionInterval;
		from: #text->#selectedText; 
		when: [:text :interval :selection | true] ;
		transformed:  [ :text :interval  :selection |
			'Text[',text asString size asString ,']: "',text asString, '"
Selection[',selection asString size asString,']: "', selection asString,'"
Interval: ', interval asString  ];
		andShow: [ :a| a text].
	"browser transmit 
		to: #details; 
		from: #text->#selectedText; 
		when: [:selection | true] ;
		transformed:  [ :selection |
			'Selection: ', selection asString ];
		andShow: [ :a| a text]."
	
	^ browser 
]

{ #category : #accessing }
SGLTextSelectionIntervalPort >> model [
	^ 1 to: 100
]
