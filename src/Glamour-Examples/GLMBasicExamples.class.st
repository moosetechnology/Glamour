"
self open
"
Class {
	#name : #GLMBasicExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMBasicExamples class >> title [ 
	^ 'Basic Examples'
]

{ #category : #others }
GLMBasicExamples >> accumulator [
	<glmBrowser: 'Accumulator' input: '42'>
	"self new accumulator openOn: 42"
	| browser acc |
	browser := GLMTabulator new.
	acc := GLMAccumulator new.
	acc show: [:a | 
		a act: #inspect entitled: 'Inspect'.
		a title: [:x | x asString]. 
		a list title: 'List'; display: [:x | 1 to: x ].
		a text title: 'Text'; display: [:x | 'This is an editor on ', x printString ].
		].
	browser column: [:c | c row: #one span: 4; row: #two]; column: #three.
	browser transmit to: #one; andShow: [:a | 
		a list display: [:x | x to: 10 * x]].
	browser transmit from: #one; to: #two; andShow: [:a |
		a text display: [:x | 'You have selected ', x printString, '. Double cick to open to the right']].
	browser transmit from: #one->#strongSelection; to: #three; andShowIfNone: [:a |
		a custom: acc ].
	browser transmit from: #one; to: #three->#entityToSelect.
	browser transmit from: #three->#activeEntity; to: #one->#selection.
	^ browser
	
]

{ #category : #private }
GLMBasicExamples >> actionsFor: aPresentation [ 
	|actions|
	aPresentation isMultiple 
							ifTrue: [actions := (aPresentation selection) ifNil: [OrderedCollection new]]
							ifFalse: [actions := OrderedCollection with: aPresentation selection ].
	^ actions collect: [:i |
					(GLMGenericAction new) 
						action: [:each | self inform: 'Menu - Item', i printString]; 
						title: 'Menu - Item', i printString; 
						yourself ]
]

{ #category : #others }
GLMBasicExamples >> allowAllNil [
	<glmBrowser: 'Allowing all nil' input: '5'>
	"self new allowAllNil openOn: 5"
	| browser |
	 
	browser := GLMTabulator new.
	browser 
		column: [: c | c row: #one; row: #two];
		column: #details.
	browser showOn: #one; using: [
		browser tree 
			display:[ :x| 1 to: x ];
			allowDeselection ].
	browser showOn: #two; using: [
		browser tree 
			display: #(a b c);
			allowDeselection].
	browser showOn: #details; from: #one; from: #two; using: [
		browser text 
			display: [ :one :two | 'At least one is nil: ', one asString, '-', two asString];
			allowNil.
		browser text 
			display: [ :one :two | 'All are nil: ', one asString, '-',  two asString];
			allowAllNil ].
		
	"if you need initial display"
	browser transmit to: #details; andShow: [:a | 
		a text display: [:x | 'All are nil'  ] ].
	
	^ browser
]

{ #category : #others }
GLMBasicExamples >> allowNil [
	<glmBrowser: 'Allowing nil' input: '42'>
	"self new allowNil openOn: 42"
	| browser | 
	browser := GLMTabulator new.
	browser 
		column: [: c | c row: #one; row: #two];
		column: #details.
	browser showOn: #one; using: [
		browser tree 
			display: #(1 2 3);
			allowDeselection ].
	browser showOn: #two; using: [
		browser tree 
			display: #(a b c);
			allowDeselection].
	browser showOn: #details; from: #one; from: #two; using: [
		browser text 
			display: [ :one :two | one asString, two asString];
			allowNil ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> browserWithToolbar [
	<glmBrowser: 'Toolbar' input: '$z'>
	"self new browserWithToolbar openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder act: [:f | f inspect] icon: MenuIcons smallFindIcon entitled: 'Inspect with icon'.
	finder act: [:f | f inspect] entitled: 'Inspect without icon'.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			dynamicActions: [:list | self actionsFor: list ];
			dynamicActionsOnSelection: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #others }
GLMBasicExamples >> compoundTaggedTree [
	<glmBrowser: 'Tags' input: '#(window help home)'>
	"self new compoundTaggedTree openOn: #(window help home)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			title: 'Combined Tags';
			tags: [:each | { {MenuIcons perform: (each, 'Icon') asSymbol . each asString }}].
		browser tree
			title: 'Image Tags';
			tags: [:each | { MenuIcons perform: (each, 'Icon') asSymbol}].
		browser tree
			title: 'Combined Tags - Filter by image';
			tags: [:each | 
				{ each == #help 
						ifTrue:[ {MenuIcons smallDeleteIcon . 'no ok' } ] 
						ifFalse:[ {MenuIcons smallOkIcon . each asString } ]} ];
			tagsFilter: [:each | 
				{ each == #help 
						ifTrue:[ MenuIcons smallDeleteIcon ] ifFalse:[ MenuIcons smallOkIcon ] } ].
		browser tree
			title: 'Combined Tags - Filter by label';
			tags: [:each | 
				{ {MenuIcons perform: (each, 'Icon') asSymbol.
					each == #help ifTrue:[ 'no ok' ] ifFalse:[ 'ok' ]}} ];
			tagsFilter: [:each | 
				{ each == #help ifTrue:[ 'no ok' ] ifFalse:[ 'ok' ] } ] ].
	^ browser
]

{ #category : #composite }
GLMBasicExamples >> differentComposites [
	"self new differentComposites openOn: (1 to: 100)"
	<glmBrowser: 'Composite arrangements' input: '(1 to: 100)'>	
	| browser |
	browser := GLMTabulator new.
	browser row: [:r | 
		r column: #tabbed; column: #accordion; column: #stackedVertically] span: 4; row: #preview.
	browser transmit to: #tabbed; andShow: [:a | 
		a title: 'Tabs'.
		a list title: 'List'. a text title: 'Text' ].
	browser transmit to: #accordion; andShow: [:a | 
		a accordionArrangement.
		a title: 'Accordion'.
		a list title: 'List'. a text title: 'Text' ].
	browser transmit to: #stackedVertically; andShow: [:a | 
		a title: 'Stack'.
		a stackedVerticallyArrangement.
		a list title: 'List'. a text title: 'Text' ].
	browser transmit to: #preview; from: #tabbed; andShow: [:a | 
		a text display: [:x | x printString, ' from tabbed' ]].
	browser transmit to: #preview; from: #accordion; andShow: [:a | 
		a text display: [:x | x printString, ' from accordion' ]].
	browser transmit to: #preview; from: #stackedVertically; andShow: [:a | 
		a text display: [:x | x printString, ' from stacked vertically' ]].
	^ browser 
]

{ #category : #others }
GLMBasicExamples >> doubleClick [
	<glmBrowser: 'Double click' input: '100'>
	"self new doubleClick openOn: 100"
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser list display: [:x | 1 to: x]].
	browser showOn: #two; from: #one->#strongSelection; using: [
		browser list display: [:x | 1 to: x]].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> dropDownList [
	"	| browser |
		browser := self new dropDownList.
		browser openOn: 5. "
	|browser |

	browser := GLMTabulator new.
	browser row: #one  size: 30; row: #two.
	browser showOn: #one; using: [
		browser dropDownList
			display: [:x | 1 to: x ];
			format: [:number | Text string: number printString attribute: TextColor red]].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x asNumber * 2]].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> dropDownListWithInitialValue [
	"	| browser |
		browser := self new dropDownListWithInitialValue.
		browser openOn: 5.
		((browser paneNamed: #one) port: #selection) value: 12. "
	|browser |

	browser := GLMTabulator new.
	browser row: #one  size: 30; row: #two.
	browser showOn: #one; using: [
		browser dropDownList
			display: [:x | (1 to: x) + 10 ];
		   selectedIndex: 2 ].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x asNumber ]].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> fixSizePanes [
	<glmBrowser: 'Fix size pane' input: '5'>
	"self new fixSizePanes openOn: 1"
	| browser |
	browser := GLMTabulator new.
	browser row: #variable; row: #fix size: 20.
	browser transmit to: #fix; andShow: [ :a | a label display: 'Fix size'].
	browser showOn: #variable; using: [browser text display: 'Variable size'].
	^ browser 
]

{ #category : #others }
GLMBasicExamples >> interdependentPanes [
	<glmBrowser: 'Two inter-dependent panes' input: '5'>
	"self new interdependentPanes openOn: 5"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser list
			display: [:x | 1 to: x * 3]].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x * 3]].
	browser showOn: #one; from: #two; using: [
		browser list
			display: [:x | 1 to: x * 3]].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> listsWithUpdatedSelection [
	"self new listsWithUpdatedSelection openOn: 10"
	<glmBrowser: 'Updated selection' input: '10'>
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser tree
			display: [:x | 1 to: x ]].
	browser showOn: #two; using: [
		browser tree
			display: [:x | 1 to: x + 2 ]].
	browser showOn: #three; using: [
		browser tree
			beMultiple;
			display: [:x | 1 to: x ]].
	browser sendTo: #two->#selection from: #one with: [:x | x + 2].
	browser sendTo: #one->#selection from: #two with: [:x | x - 2].
	browser sendTo: #three->#selection from: #two with: [:x | (1 to: (x - 2)) ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> mondrianPainting [
	<glmBrowser: 'Mondrian painting' input: '100'>
	"self new mondrianPainting openOn: 100"
	| browser items |
	browser := GLMTabulator withStatusbar.
	items := 50.
	browser act: [:b | 
		items := 10.
		(b paneNamed: #one) presentations first update ] entitled: 'Update'.
	browser act: [:b | 
		(b paneNamed: #one) inspect ] entitled: 'Inspect'.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser mondrian 
			title: 'Numbers in Mondrian tree';
			painting: [:view :number | 
			view shape label.
			view nodes: (1 to: items ).
			view edgesFrom: [:x | x // 3 ].
			view horizontalTreeLayout ]].
	browser showOn: #two; from: #one; using: [
		browser mondrian 
			title: 'Numbers in Mondrian list';
			painting: [:view :number |
				view shape rectangle width: 20; text: #printString; withoutBorder.
				view nodes: (1 to: number).
				view gridLayout ]].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> morphIcons [
	<glmBrowser: 'Morph icons' input: 'ThemeIcons class selectors select: [:each | (ThemeIcons perform: each) isForm ]'>
	"self new morphIcons openOn: (ThemeIcons class selectors select: [:each | (each endsWith: 'Icon') and: [(ThemeIcons perform: each) isForm ]])"
	| browser |
	browser := GLMTabulator new.
	browser column: #list; column: #preview.
	browser title: 'OBMorphicIcons'.
	browser showOn: #list; using: [
		browser list ].
	browser showOn: #preview; from: #list; using: [
		browser morph
			display: [:symbol | 
				(ThemeIcons iconNamed: symbol) asMorph ] ].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> multiInitialSelection [
	"
		| browser |
		browser := self new multiInitialSelection.
		browser openOn: 5.
		(browser panes first port: #selection) value: #(2 5 3).
	"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			beMultiple;
			display: [:x | 1 to: x * 3]].
	browser showOn: #two; from: #one; using: [
		browser list ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> multipleActions [
	<glmBrowser: 'Multiple actions' input: 'This example shows how multiple actions are rendered.'>
	"self new multipleActions openOn: 'This example shows how multiple actions are rendered.'"
	|browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a text 
			title: 'Example';
			selectionAct: [:text | text inspect ] on: $i entitled: 'Selection action';
			act: [:text | text inspect ] on: $i entitled: 'Action without icon';
			act: [:text | text inspect ] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Action with icon' ].
	^ browser
]

{ #category : #'searching and filtering' }
GLMBasicExamples >> multipleFinderWithFilter [
	<glmBrowser: 'Filter' input: '$a to: $z'>
	"self new multipleFinderWithFilter openOn: ($a to: $z)"

	| finder |	
	finder := GLMFinder new.
	finder list
			title: 'List';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ].
	finder tree
			title: 'Tree';
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ].
	^ finder 
]

{ #category : #'searching and filtering' }
GLMBasicExamples >> multipleFinderWithFilterAndSearch [
	<glmBrowser: 'Search' input: '$a to: $z'>
	"self new multipleFinderWithFilterAndSearch openOn: (1 to: 100)"

	| finder |	
	finder := GLMFinder new.
	finder list
			beMultiple;
			title: 'Simple';
			dynamicActions: [:list | self actionsFor: list].
	finder list
			title: 'With filter';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each].
	finder list
			title: 'With search';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			searchOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each].
	^ finder 
]

{ #category : #'tabs examples' }
GLMBasicExamples >> multipleTabs [
	<glmBrowser: 'Tabs' input: '1'>
	"self new multipleTabs openOn: 1"
	
	| finder |
	finder := GLMFinder new.
	(1 to: 3) do: [:i | 
		finder text
			title: i printString;
			display: [:x | i printString].
		finder text
			titleIcon: MenuIcons smallFindIcon;
			display: [:x | i printString]
	].
	
	^ finder
]

{ #category : #actionlist }
GLMBasicExamples >> simpleActionList [
	<glmBrowser: 'Action list' input: '#(1 2 3)'>	
	"self new simpleActionList openOn: #(1 2 3)"
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser actionList
			act: [:entity | Transcript show: entity ] entitled: 'Transcript';
			act: [:entity | entity inspect ] entitled: 'Inspect'].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> simpleExpander [
	<glmBrowser: 'Simple Expander' input: '#(a b c)'>
	"self new simpleExpander  openOn: #(a b c)"
	| browser |
	browser := GLMExpander new.
	browser show: [ :a | 
		a title: [:x | x ].
		a text title: 'text1'. 
		a text title: 'text2'.].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	<glmBrowser: 'Browser menu' input: '$z'>
	"self new simpleFinderWithMenu openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			dynamicActionsOnSelection: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #table }
GLMBasicExamples >> simpleTable [
	<glmBrowser: 'Simple table' input: '100'>
	"self new simpleTable openOn: 1000"
	| finder |	
	finder := GLMFinder new.
	finder table
			display: [ :x | 1 to: x ]; 
			dynamicActions: [ :list | self actionsFor: list ];
			column: [:x | 'Numbers from 1 to ', x asString] evaluated: #asString;
			column: 'Even' evaluated: [ :each | each even asString ];
			column: 'Odd' evaluated: [ :each | each odd asString ].
	^ finder
]

{ #category : #'explicit selection' }
GLMBasicExamples >> singleInitialSelection [
	"
		| browser |
		browser := self new singleInitialSelection.
		browser openOn: 5.
		(browser panes first port: #selection) value: 3.
	"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			display: [:x | 1 to: x];
			format: [:number | Text string: number printString attribute: TextColor red]].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x * 2]].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> stacker [
	<glmBrowser: 'Stacker' input: '5'>
	"self new stacker openOn: 5"
	
	| browser |
	browser := GLMStacker new.
	browser aPane: #x; aPane: #y.
	browser transmit to: #x; andShow: [ :a | 
		a title: 'x'.
		a list display: [:x | 1 to: x ]].
	browser transmit to: #y; andShow: [:a | 
		a title: '10 * x'.
		a list display: [:x |  1 to: (10*x )] ].
	^ browser 
]

{ #category : #others }
GLMBasicExamples >> starBrowser [
	"self new starBrowser openOn: { Boolean. String. #asString. #printString }"

	| browser accumulator |
	browser := GLMTabulator new.
	browser title: 'StarBrowser Light'.
	browser column: #tree; column: #browser span: 4.
	browser showOn: #tree; using: [ browser list ].
	accumulator := GLMAccumulator new.
	accumulator show: [ :a |
		a title: [:object | object printString ].
		a morph
			display: [ :object |
				| model |
				" create omnibrowser model "
				model := object isBehavior
					ifTrue: [ OBHierarchyBrowser onClass: object ]
					ifFalse: [ OBImplementorsBrowser root: (OBSelectorNode on: object) ].
				" create omnibrowser morph, but get rid of window "
				PanelMorph new
					layoutPolicy: ProportionalLayout new;
					addAllMorphs: (OBMorphBuilder build: model) paneMorphs;
					yourself ] ].
	browser transmit to: #browser; from: #tree->#strongSelection; andShowIfNone: [ :a |
		a custom: accumulator ].
	^ browser 
]

{ #category : #'actions examples' }
GLMBasicExamples >> staticAndDynamicMenu [
	<glmBrowser: 'Menus' input: '$z'>
	"self new staticAndDynamicMenu openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			dynamicActionsOnSelection: [:list | self actionsFor: list ];
			selectionAct: [self inform: 'static action'] entitled: 'Static action';
			selectionAct: [self inform: 'static sub action'] entitled: 'Static sub action' categorized: 'Sub menu'.
	finder text
			title: 'Text';
			display: [:each | 'Character ', each asString];
			dynamicActionsOnSelection: [:text | OrderedCollection with: (GLMGenericAction new title: 'Print selection'; action: [Transcript show: text selection]; yourself) ];
			selectionAct: [self inform: 'Text static action'] entitled: 'Static action'.
	^ finder
]

{ #category : #'actions examples' }
GLMBasicExamples >> tableWithIcons [
	<glmBrowser: 'Icons' input: '($A to: $z)'>
	"self new tableWithIcons openOn: ($A to: $z)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a act: [:presentation | presentation inspect] entitled: 'Inspect'. 
		a table
			title: 'Table with actions';
			act: [:presentation | presentation inspect] entitled: 'Inspect'; 
			column: 'Character' evaluated: [ :each | each asString ];
			column: 'ASCII' evaluated: [ :each | each asInteger printString ];
			selectionAct: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser transmit to: #two; from: #one; andShow: [:a | a text ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> taggedTree [
	"self new taggedTree openOn: #(1 2 3 4 5)"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a tree
			tags: [:each | 
				{each even ifTrue: ['even'] ifFalse: ['odd'].
				each even ifTrue: ['x'] ifFalse: ['y']}
				]].
	browser transmit to: #two; from: #one; andShow: [ :a |
		a text
			display: [:x | 'You have selected ', x printString ]].
	^ browser
]

{ #category : #text }
GLMBasicExamples >> textPortsExamples [
	"
		self new textPortsExamples openOn: 'Type and select to see the results previewed.'
	"
	| browser |
	browser := GLMTabulator new.
	browser row: #main; row: [:r | r column: #selected; column: #full].
	browser transmit to: #main; andShow: [:a | a text].
	browser transmit to: #selected; from: #main->#selectedText; andShow: [:a | a text].
	browser transmit to: #full; from: #main->#text; andShow: [:a | a text].
	^ browser
]

{ #category : #text }
GLMBasicExamples >> textSelectionInterval [
	<glmBrowser: 'Text selection' input: '(1 to: 100)'>
	"	|browser |
		browser := self new textSelectionInterval.
		browser openOn: (1 to: 100).
		((browser paneNamed: #start) port: #selection) value: 2.
		((browser paneNamed: #end) port: #selection) value: 5.		
	"
	| browser |
	browser := GLMTabulator new.
	browser row: [ :r | r column: #start; column: #end ]; row: #text.
	browser transmit to: #start; andShow: [ :a | a list title: 'Start' ].
	browser transmit to: #end; andShow: [ :a | a list title: 'End' ].
	browser transmit to: #text; andShow: [ :a | 
		a text 
			title: 'Text with selection';
			display: 'some piece of text to test the selection interval on.'].
	browser transmit to: #text->#selectionInterval; from: #start; from: #end; when: [:s :e | s notNil & e notNil] ; transformed: [ :s :e | s to: e ].
"	browser transmit to: #start->#selection; from: #text->#selectionInterval; transformed: [:interval | interval first].
	browser transmit to: #end->#selection; from: #text->#selectionInterval; transformed: [:interval | interval last].
"	^ browser
]

{ #category : #others }
GLMBasicExamples >> threeInterdependentPanes [
	<glmBrowser: 'Three inter-dependent panes' input: '5'>
	"self new threeInterdependentPanes openOn: 5"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser transmit to: #one; andShow: [ :a |
		a tree
			display: [:x | 1 to: x]].
	browser transmit to: #two; from: #one; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x*2]].
	browser transmit to: #three; from: #two; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser transmit toOutside: #focus; from: #three->#focus.
	browser transmit to: #one->#selection; from: #outer->#focus.
	browser transmit to: #two->#selection; from: #outer->#focus.
	^ browser
]

{ #category : #others }
GLMBasicExamples >> treeWithAmountFiltering [
	<glmBrowser: 'Smart lists' input: '(1 to: 10000)'>
	"self new treeWithAmountFiltering openOn: (1 to: 10000)"
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a tree
			tags: [ :each | {each even printString} ];
			showOnly: 50 ].
	^ browser 
]

{ #category : #'explicit selection' }
GLMBasicExamples >> treeWithChildrenByLevel [
	<glmBrowser: 'Tree with children by level' input: '(1 to: 5)'>
	"
		self new treeWithChildrenByLevel openOn: #(1 2 3 4 5)
	"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: [:c | c row: #two; row: #three].
	browser transmit to: #one; andShow: [ :a |
		browser tree
			title: 'Tree';
			children: [:item :x :level | level > 1 ifTrue: [#()] ifFalse: [1 to: item ] ] "Children must return a collection"].
	browser transmit to: #two; from: #one; andShow: [:a | 
		a text title: 'Selection preview' ].
	browser transmit to: #three; from: #one->#selectionPath; andShow: [:a | 
		a text title: 'Selection path preview'].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> treeWithExpansion [
	<glmBrowser: 'Tree with expansion' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))'>
	"self new treeWithExpansion openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [:a |
		a tree
			title: 'No expansion';
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ].
		a tree
			title: 'Roots expanded';
			rootsExpanded;
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ].
		a tree
			title: 'All expanded';
			allExpanded;
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser transmit to: #two; from: #one; andShow: [ :a | a text ].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> treeWithInitialSelection [
	"
		| browser |
		browser := self new treeWithInitialSelection. 
		browser openOn: {
			#first->{$a->{}. $c->{}. $d->{}}.
			#second->{$e->{}. $f->{}}. 
			#third->{$h->{}}
		}.
		(browser panes first port: #selection) value: $a->{}.
	"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: [:c | c row: #two; row: #three].
	browser transmit to: #one; andShow: [ :a |
		a tree
			title: 'first tree';
			children: [:x | x value ].
		a tree
			title: 'second tree';
			children: [:x | x value ]].
	browser transmit to: #two; from: #one; andShow: [ :a | browser text title: 'Selection preview' ].
	browser transmit to: #three; from: #one->#selectionPath; andShow: [ :a | a text title: 'Selection path preview'].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> treeWithMenu [
	<glmBrowser: 'Tree with menu' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j $l))'>
	"self new treeWithMenu openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j $l))"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a tree
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ];
			selectionAct: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser transmit to: #two; from: #one; andShow: [:a | a text ].
	^ browser
]

{ #category : #updating }
GLMBasicExamples >> updatableBrowser [
	<glmBrowser: 'Updateable browser' input: '|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new updatableBrowser openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #automatic; column: #menu.
	browser act: [:b | b entity add: (b entity size + 1) ] entitled: 'Add an item in the collection'.
	browser act: [:b | b entity removeLast ] entitled: 'Remove last item from the collection'.
	browser act: [:b | b update ] entitled: 'Update complete browser'.
	browser transmit to: #automatic; andShow: [ :a |
		a title: 'Updated automatically'.
		a stackedArrangement.
		a list title: [:x | 'List: ', x size printString ];
			shouldValidate: true;
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself.
		a text title: 'Text';
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself .
		a mondrian title: 'Mondrian';
			updateOn: GLMItemAdded from: #yourself;
			updateOn: GLMItemRemoved from: #yourself;
			painting: [:view :entity | 
				view shape label.
				view nodes: entity ] ].
	browser transmit to: #menu; andShow: [ :a |
		a title: 'Updated via menu'.
		a stackedArrangement.
		a list title: 'List';
			shouldValidate: true;
			act: [:p | p update] entitled: 'Update'.
		a text title: 'Text'; act: [:p | p update] entitled: 'Update'.
		a mondrian title: 'Mondrian';
			act: [:p | p update] entitled: 'Update';
			painting: [:view :entity | 
				view shape label.
				view nodes: entity ] ].
	^ browser
]

{ #category : #text }
GLMBasicExamples >> updateAction [
	<glmBrowser: 'Update action' input: 'String withAll: ''Select a piece of text and open on the next pane via the contextual menu or by pressing Modifier+o. Otherwise just open the complete copy of the current text on the next pane via the menu or by pressing Modifier+l.'''>
	"self new updateAction openOn: 'Select a piece of text and open on the next pane'"
	| browser |
	browser := GLMFinder new.
	browser text
		populate: #selection on: $o entitled: 'Open selection on next pane' with: [:text | text selectedText ];
		populate: #selection on: $l entitled: 'Open complete text on next pane' with: [:text | text text ].
	^ browser 
]
