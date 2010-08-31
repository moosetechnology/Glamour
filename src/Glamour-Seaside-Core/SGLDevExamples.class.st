Class {
	#name : #SGLDevExamples,
	#superclass : #SGLExamples,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #accessing }
SGLDevExamples class >> applicationUrl [
	^ 'glamour/devExamples'
]

{ #category : #other }
SGLDevExamples >> accumulatorWithActions [
	"
		self new accumulatorWithActions openOn: 42
	"
	<glmBrowser: 'Accumulator with actions' input: '42'>
	| browser acc|
	browser := GLMTabulator new.
	browser title: 'A tabulator'.
	acc := GLMAccumulator new.
	acc title: 'An accumulator'.
	acc show: [:a |
		a title: [:x | x asString].

		a act: [:ac :entity| Transcript show: 'Accumulator action '; cr ] icon: MenuIcons helpIcon entitled: 'Accumulator action'.

		a list 
			title: 'List';
			showOnly: 10;
			act: [:list :entity| 
				Transcript show: 'List action 1 for accumulator'; cr ] icon: MenuIcons jumpIcon entitled: 'List action 1 for accumulator';

			display: [:x |1 to: x ].
		a text 
			title: 'Text'; 
			display: [:x | 'This is an editor on ', x printString ];
			act: [:list :entity| Transcript show: 'Text action 1 for accumulator'; cr ] icon: MenuIcons helpIcon  entitled: 'Text action 1 for accumulator'.
		].
	browser column: [:c | c row: #one span: 4; row: #two]; column: #three; column: #four.
	browser transmit to: #one; andShow: [:a | 
		a list 
			title: 'List presentation';
			display: [:x | x to: 10 * x]; showOnly: 10].
	browser transmit from: #one; to: #two; andShow: [:a |
		a text display: [:x | 'You have selected ', x printString]].
	browser transmit from: #one; to: #three; andShowIfNone: [:a |
		a custom: acc ].
	
	browser transmit from: #one; to: #three->#entityToSelect.
	browser transmit from: #three->#activeEntity; to: #one->#selection.
	
	browser transmit from: #three; to: #four; andShow: [ :a |
		a list display: [:x| 1 to: x]	].

	^ browser
	

]

{ #category : #other }
SGLDevExamples >> differentCompositesWithActions [
	"
		self new differentCompositesWithActions openOn: 100
	"
	<glmBrowser: 'Composite arrangements with actions' input: '100'>
	|browser|

	browser := GLMTabulator new.
	browser column:  #tab; column: #accordion; column: #stack.

	browser transmit  to: #tab; andShow: [ :a |
		a title: 'Tab arrangement'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Tab arrangement action 1'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 2'; cr ] icon: MenuIcons helpIcon  entitled: 'Tab arrangement action 2'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 3'; cr ] icon: MenuIcons jumpIcon entitled: 'Tab arrangement action 3'.
		a act: [:list :entity| Transcript show: 'Tab arrangement action 4'; cr ] icon: MenuIcons helpIcon  entitled: 'Tab arrangement action 4'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First tab action 1';
			act: [:list :entity| Transcript show: 'First tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			act: [:list :entity| Transcript show: 'Second tab action 1'; cr ] icon: MenuIcons publishIcon entitled: 'Second tab action 1';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			act: [:list :entity| Transcript show: 'Third tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Third tab action 1';
			act: [:list :entity| Transcript show: 'Third tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Third tab action 2';
			act: [:list :entity| Transcript show: 'Third tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'Third tab action 3';
			act: [:list :entity| Transcript show: 'Third tab action 4'; cr ] icon: MenuIcons publishIcon entitled: 'Third tab action 4';
			display:  [ :x | 1 to: x ] ].

	browser transmit  to: #accordion; andShow: [ :a |
		a accordionArrangement.
		a act: [:list :entity| Transcript show: 'Accordion arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Accordion arrangement action 1'.
		a title: 'Accordion arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First accordion tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First accordion tab action 1';
			act: [:list :entity| Transcript show: 'First accordion tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First accordion tab action 2';
			act: [:list :entity| Transcript show: 'First accordion tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'First accordion tab action 3';
			act: [:list :entity| Transcript show: 'First accordion tab action 4'; cr ] icon: MenuIcons projectIcon entitled: 'First accordion tab action 4';
			act: [:list :entity| Transcript show: 'First accordion tab action 5'; cr ] icon: MenuIcons jumpIcon entitled: 'First accordion tab action 5';
			act: [:list :entity| Transcript show: 'First accordion tab action 6'; cr ] icon: MenuIcons paintTabIcon entitled: 'First accordion tab action 6';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			act: [:list :entity| Transcript show: 'Second accordion tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Second accordion tab action 1';
			act: [:list :entity| Transcript show: 'Second accordion tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Second accordion tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			display:  [ :x | 1 to: x ] ].
		
	browser transmit  to: #stack; andShow: [ :a |
		a stackedVerticallyArrangement.
		a act: [:list :entity| Transcript show: 'Stacked arrangement action 1'; cr ] icon: MenuIcons jumpIcon entitled: 'Stacked arrangement action 1'.
		a title: 'Stack arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			act: [:list :entity| Transcript show: 'First stacked tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'First stacked tab action 1';
			act: [:list :entity| Transcript show: 'First stacked tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'First stacked tab action 2';
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			act: [:list :entity| Transcript show: 'Third stacked tab action 1'; cr ] icon: MenuIcons projectIcon entitled: 'Third stacked tab action 1';
			act: [:list :entity| Transcript show: 'Third stacked tab action 2'; cr ] icon: MenuIcons jumpIcon entitled: 'Third stacked tab action 2';
			act: [:list :entity| Transcript show: 'Third stacked tab action 3'; cr ] icon: MenuIcons paintTabIcon entitled: 'Third stacked tab action 3';
			display:  [ :x | 1 to: x ] ].
		
	^browser 
]

{ #category : #other }
SGLDevExamples >> longTabulator [
	"
		self new longTabulator openOn: (MooseModel root allModels first allMethods entityNamed: #'org::argouml::model::Facade.getName()' )
	"
	<glmBrowser: 'Long Tabulator' input: '(MooseModel root allModels first allMethods entityNamed: #''org::argouml::model::Facade.getName()'' )'>
	|browser|
	browser := GLMTabulator new.
	browser column:  #col1; column:  #col2; column: #col3.
	browser transmit to: #col1; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName;
			showOnly: 30 ].
	browser transmit to: #col2; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName;
			showOnly: 200 ].
	browser transmit to: #col3; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			format: #mooseName ].
	
	^browser
]

{ #category : #other }
SGLDevExamples >> methodsInvocations [
	"
		self new methodsInvocations openOn: (MooseModel root allModels first allMethods entityNamed: #'org::argouml::model::Facade.getName()' )
	"
	<glmBrowser: 'Methods Invocations' input: '(MooseModel root allModels first allMethods entityNamed: #''org::argouml::model::Facade.getName()'' )'>
	|innerBrowser finder|
	innerBrowser := GLMTabulator new.
	innerBrowser row: #methods; row: #source.
	innerBrowser transmit to: #methods; andShow: [ :a | 
		a list
			title: [:each | 'Methods invoking ', each name ];
			display: #invokingMethods ;
			showOnly: 50;
			format: #mooseName ].
	innerBrowser transmit from: #methods; to: #source; andShow: [:a |
		a text display: #sourceText ].
	
	innerBrowser transmit from: #methods; toOutside: #selection.
	
	finder  := GLMFinder new.
	finder title: [ :each | 'Reference browser on ', each mooseName ].
	finder show: [ :a |
		a custom: innerBrowser ].
	
	^finder
]

{ #category : #other }
SGLDevExamples >> multipleTabPresentations [
	"
		self new multipleTabPresentations openOn: 100
	"
	<glmBrowser: 'Multiple tab presentations' input: '100'>
	|browser|

	browser := GLMTabulator new.
	browser row: #justARow.

	browser transmit  to: #justARow; andShow: [ :a |
		"a title: 'A tab presentation."
		"a stackedVerticallyArrangement."
		a list
			title: 'First';
			showOnly: 10;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Second';
			showOnly: 20;
			display:  [ :x | 1 to: x ].
		a list
			title: 'Third';
			showOnly: 70;
			display:  [ :x | 1 to: x ] .
		a list
			title: 'Fourth';
			showOnly: 524;
			display:  [ :x | 1 to: x ] .
		a list
			title: 'Fifth';
			display:  [ :x | 1 to: x ] ].
		
	^browser
]

{ #category : #other }
SGLDevExamples >> namespacesDependencies [
	"
		self new simpleTree openOn: MooseModel root allModels first allModelNamespaces
	"
	<glmBrowser: 'Namespaces Dependencies' input: 'MooseModel root allModels first allModelNamespaces'>
	| finder |
	finder := GLMFinder new.
	finder title: 'Finder'.
	finder show: [ :a |
		a list 
			showOnly: 30;
			title: 'A Finder';
			format: #mooseName;
			send: #providerNamespaces ].
		
	^finder.
]

{ #category : #other }
SGLDevExamples >> onePaneWithList [
	"
		self new onePaneWithList openOn: 100
	"
	<glmBrowser: 'One pane with list' input: '100'>
	|browser|
	
	browser := GLMTabulator new.
	browser row: #justARow.
	browser title: 'Tabulator'.
	
	browser transmit to: #justARow; andShow: [ :a |
		a list
			showOnly: 20;
			title: 'A list presentation';
			display:  [ :x | 1 to: x ] ].

	^browser 
]

{ #category : #other }
SGLDevExamples >> simpleTree [
	"
		self new simpleTree openOn: (1 to: 100)
	"
	<glmBrowser: 'Simple tree' input: '1 to: 100'>
	|browser|

	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			title: 'No expansion';
			children: [:item | 1 to: 4];
			showOnly: 10.
		browser tree
			title: 'Roots expanded';
			rootsExpanded;
			children: [:item | 1 to: 4];
			showOnly: 10 ].

	^ browser
]

{ #category : #other }
SGLDevExamples >> tabsWithActions [
	"
		self new tabsWithActions openOn: 18
	"
	<glmBrowser: 'Tabs with actions' input: '18'>
	|browser|
	browser := GLMTabulator new.
	browser column: #aColumn.

	browser transmit  to: #aColumn; andShow: [ :a |
		a title: 'Tab arrangement'.
		a list
			title: 'First';
			showOnly: 10;
			display:  [ :x | 1 to: x ];
			act: [:list :entity| Transcript show: '+1'; cr ] icon: MenuIcons projectIcon entitled: '+1';
			act: [:list :entity| Transcript show: '+2'; cr ] icon: MenuIcons jumpIcon entitled: '+2';
			act: [:list :entity| Transcript show: '+3'; cr ] icon: MenuIcons jumpIcon entitled: '+3'.
		a list
			title: 'Second';
			showOnly: 60;
			display:  [ :x | 1 to: x ];
			act: [:list :entity| Transcript show: '-1'; cr ] icon: MenuIcons publishIcon entitled: '-1';
			act: [:list :entity| Transcript show: '-2'; cr ] icon: MenuIcons jumpIcon entitled: '-2'.
		a list
			title: 'Third';
			display:  [ :x | 1 to: x ] ;
			act: [:list :entity| Transcript show: '*1'; cr ] icon: MenuIcons paintTabIcon entitled: '*1';
			act: [:list :entity| Transcript show: '*2'; cr ] icon: MenuIcons helpIcon entitled: '*2';
			act: [:list :entity| Transcript show: '*3'; cr ] icon: MenuIcons projectIcon entitled: '*3';
			act: [:list :entity| Transcript show: '*4'; cr ] icon: MenuIcons jumpIcon entitled: '*4'  ].
	^browser
]

{ #category : #other }
SGLDevExamples >> textSelectedTextPort [
	"
		self new textSelectedTextPort openOn: 20
	"
	<glmBrowser: 'Text presentation - selected text port' input: '20'>
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

{ #category : #other }
SGLDevExamples >> textSelectionIntervalPort [
	"
		self new textSelectionIntervalPort openOn: (1 to: 100)
	"
	<glmBrowser: 'Text presentation - selection interval port' input: '1 to: 100'>
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

{ #category : #other }
SGLDevExamples >> textSelectionPorts [
	"
		self new textSelectionPorts openOn: 10
	"
	<glmBrowser: 'Text presentation - selection ports' input: '10'>
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
		andShow: [:a | a text title: 'Text with "selectedText"'].
	
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
		andShow: [:a | a text title: 'Text with "selectionInterval"'].
	
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

{ #category : #other }
SGLDevExamples >> textTextPorts [
	"
		self new textSelectionPorts openOn: 'Type and select to see the 
	results previewed.'
	"
	<glmBrowser: 'Text presentation - text port' input: '''Type and select to see the 
	results previewed'''>
	| browser |
	GLMLogger instance: GLMMemoryLogger new.
	browser := GLMTabulator new.
	browser 
		row: #main; 
		row: [:r | r column: #full1; column: #fullFromTransmision1]; 
		row: [:r | r column: #full2; column: #fullFromTransmision2].
	browser showOn: #main; using: [browser text].
	
	browser showOn: #full1; from: #main->#text; using: [browser text].
	browser showOn: #fullFromTransmision1; using: [browser text].
	browser transmit to: #fullFromTransmision1->#text; from: #main->#text; when: [:text| text notNil].
	
	browser showOn: #full2; from: #full1->#text; using: [browser text].
	browser showOn: #fullFromTransmision2; using: [browser text].
	browser transmit to: #fullFromTransmision2->#text; from: #fullFromTransmision1->#text; when: [:text| text notNil].
	
	^ browser
]

{ #category : #accessing }
SGLDevExamples >> title [
	^ 'DevExamples'
]

{ #category : #other }
SGLDevExamples >> treeWithTags [
	"
		self new treeWithTags openOn: #( (1 2 3 4) (5 6 7 (8 9 99) (10 11) ( (12 13) (13 15) ) ) (16 17 18  (19 20 21 22) (23 24 25 26)) )
	"
	<glmBrowser: 'Tree with tags' input: '#( (1 2 3 4) (5 6 7 (8 9 99) (10 11) ( (12 13) (13 15) ) ) (16 17 18  (19 20 21 22) (23 24 25 26)) )'>
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			title: 'No expansion';
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{each even ifTrue: ['even'] ifFalse: ['odd'] } ]
				ifFalse: [
					{each size even ifTrue: ['even'] ifFalse: ['odd'] } ] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ].
			
		browser tree
			title: 'All Expanded';
			allExpanded;
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{each even ifTrue: ['even'] ifFalse: ['odd'] } ]
				ifFalse: [
					{each size even ifTrue: ['even'] ifFalse: ['odd'] } ] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]
