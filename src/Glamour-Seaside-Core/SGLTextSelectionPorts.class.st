Class {
	#name : #SGLTextSelectionPorts,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTextSelectionPorts class >> initialize [
	self registerAsApplication: 'glamour/text/selectionPorts'
]

{ #category : #accessing }
SGLTextSelectionPorts >> browser [
	| browser |
	browser := GLMTabulator new.
	browser 
		row: [:r | 
			r column: [:c | c row: #text1; row: #selectedText]; 
			  column: [:c | c row: #selection11; row: #details11 ];
			  column: [:c | c row: #text2; row: [:r1 | r1 column: #selectionIntervalStart; column: #selectionIntervalStop ]];
			  column: [:c | c row: #selection21; row: #details21 ] ].
		
	browser showOn: #text1; using: [
		browser list
			title: 'Text port';
			beMultiple;
			allowDeselection;
			display: [:x| 1 to: x ]].
		
	browser showOn: #selectedText; using: [
		browser list
			title: 'SelectedText port';
			beMultiple;
			allowDeselection;
			display: [:x| 1 to: x ]].
	
	browser transmit 
		to: #selection11;
		transformed: [:value | ''];
		andShow: [:a | a text title: 'Text with "selectedText" populated'].
	
	browser transmit 
		to: #selection11->#text;
		from: #text1->#selection;	
		transformed: [:list| |value|
			value := ''.
			list ifNil: [value := nil] ifNotNil:  [ list do: [:each | value := value, each asString ] ].
			value ].
		
	browser transmit 
		to: #selection11->#selectedText;
		from: #selectedText->#selection;	
		transformed: [:list| |value|
			value := ''.
			list ifNil: [value := nil] ifNotNil:  [ list do: [:each | value := value, each asString ] ].
			value ].
	
	browser transmit 
		to: #details11; 
		from: #selection11->#text;
		from: #selection11->#selectionInterval;
		from: #selection11->#selectedText; 
		when: [:text :interval :selection | true] ;
		transformed:  [ :text :interval  :selection |
			'Text[',text asString size asString ,']: "',text asString, '"
Selection[',selection asString size asString,']: "', selection asString,'"
Interval: ', interval asString  ];
		andShow: [ :a| a text title: 'Details'].
		
		""""""""""""""""""""""""""""
		
	browser showOn: #text2; using: [
		browser list
			title: 'Text port';
			beMultiple;
			allowDeselection;
			display: [:x| 1 to: x ]].
		
	browser showOn: #selectionIntervalStart; using: [
		browser list
			title: 'SelectionInterval start';
			allowDeselection;
			display: [:x| 1 to: x ]].
	browser showOn: #selectionIntervalStop; using: [
		browser list
			title: 'SelectionInterval Stop';
			allowDeselection;
			display: [:x| 1 to: x ]].
	
	browser transmit 
		to: #selection21;
		transformed: [:value | ''];
		andShow: [:a | a text title: 'Text with "selectionInterval" populated'].
	
	browser transmit 
		to: #selection21->#text;
		from: #text2->#selection;	
		transformed: [:list| |value|
			value := ''.
			list ifNil: [value := nil] ifNotNil:  [ list do: [:each | value := value, each asString ] ].
			value ].
	
	browser transmit 
		to: #selection21->#selectionInterval; 
		from: #selectionIntervalStart; 
		from: #selectionIntervalStop; 
		when: [:s :e | (s notNil & e notNil) or: [s isNil & e isNil] ] ; 
		transformed: [ :s :e |  (s isNil & e isNil) ifTrue: [nil] ifFalse:  [s to: e] ].
	
	browser transmit 
		to: #details21; 
		from: #selection21->#text;
		from: #selection21->#selectionInterval;
		from: #selection21->#selectedText; 
		when: [:text :interval :selection | true] ;
		transformed:  [ :text :interval  :selection |
			'Text[',text asString size asString ,']: "',text asString, '"
Selection[',selection asString size asString,']: "', selection asString,'"
Interval: ', interval asString  ];
		andShow: [ :a| a text title: 'Details'].
		
	
	^ browser
]

{ #category : #accessing }
SGLTextSelectionPorts >> model [
	^10
]
