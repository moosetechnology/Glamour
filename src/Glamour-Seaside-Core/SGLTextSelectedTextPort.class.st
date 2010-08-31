Class {
	#name : #SGLTextSelectedTextPort,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTextSelectedTextPort class >> initialize [
	self registerAsApplication: 'glamour/text/selectedTextPorts'
]

{ #category : #accessing }
SGLTextSelectedTextPort >> browser [
	| browser |
	browser := GLMTabulator new.
	browser 
		row: [:r | r column: #numbers; column: #selection; column: #details].
		
	browser showOn: #numbers; using: [
		browser list
			title: 'Selectors';
			beMultiple;
			allowDeselection;
			display: [:x| 1 to: x ]].

	browser showOn: #selection;  using: [
		browser text
			title: 'Text with selection by "selectedText"';
			display: [:x | |value|
				value := ''.
				1 to:(x-5) do: [:index| value := value,index asString ].
				value] ].
		
	browser transmit 
		to: #selection->#selectedText; 
		from: #numbers->#selection; 
		transformed: [:list| |value|
			value := ''.
			list ifNil: [value := nil] ifNotNil:  [list do: [:each | value := value, each asString ] ].
			value].
	
	browser transmit 
		to: #details; 
		from: #selection->#text;
		from: #selection->#selectionInterval;
		from: #selection->#selectedText; 
		when: [:text :interval :selection | true] ;
		transformed:  [ :text :interval  :selection |
			'Text[',text asString size asString ,']: "',text asString, '"
Selection[',selection asString size asString,']: "', selection asString,'"
Interval: ', interval asString  ];
		andShow: [ :a| a text title: 'Details'].
	
	^ browser
]

{ #category : #accessing }
SGLTextSelectedTextPort >> model [
	^ 20
	"^ '1234567891011121314151617181920'"
]
