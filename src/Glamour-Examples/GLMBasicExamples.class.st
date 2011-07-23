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

{ #category : #browsers }
GLMBasicExamples >> accumulator [
	"self new accumulator openOn: 42"

	<glmBrowser: 'Accumulator' input: '42'>
	| browser acc |
	browser := GLMTabulator new.
	acc := GLMAccumulator new.
	acc
		show: [ :a | 
			a title: [ :x | x asString ].
			a list
				display: [ :x | 1 to: x ] ].
	browser
		column: [ :c | 
					c
						row: #one span: 4;
						row: #two ];
		column: #three.
	(browser transmit)
		to: #one;
		andShow: [ :a | a list display: [ :x | x to: 10 * x ] ].
	(browser transmit)
		from: #one;
		to: #two;
		andShow: [ :a | a text display: [ :x | 'You have selected ' , x printString , '. Double cick to open to the right' ] ].
	(browser transmit)
		from: #one port: #strongSelection;
		to: #three;
		andShowIfNone: [ :a | a custom: acc ].
	(browser transmit)
		from: #one;
		to: #three -> #entityToSelect.
	(browser transmit)
		from: #three port: #activeEntity;
		to: #one -> #selection.
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

{ #category : #browsers }
GLMBasicExamples >> dashboard [

	<glmBrowser: 'Dashboard' input: '100'>
	"self new dashboard openOn: 100"
	
	|tmpBrowser|
	tmpBrowser := GLMDashboard new.
	tmpBrowser addPaneNamed: #first.
	tmpBrowser addPaneNamed: #second.
	tmpBrowser addPaneNamed: #third.
	tmpBrowser addPaneNamed: #fourth.
	tmpBrowser addPaneNamed: #fifth.
	
	tmpBrowser transmit to: #first; andShow: [:a |
		a list
			display: [:i | #(a b c d e f g)];
			yourself
		].
	tmpBrowser transmit to: #second; andShow: [:a |
		a list
			display: [:i | #(a b c d e f g)]
		].
	tmpBrowser transmit to: #third; andShow: [:a |
		a list
			display: [:i | #(a b c d e f g)]
		].
	tmpBrowser transmit to: #fourth; andShow: [:a |
		a list
			display: [:i | #(a b c d e f g)]
		].
	tmpBrowser transmit to: #fifth; andShow: [:a |
		a list
			display: [:i | #(a b c d e f g h i j k l m n o p q r s t u v w x y z)]
		].
	^ tmpBrowser
]

{ #category : #browsers }
GLMBasicExamples >> dashboardWithSpecificExtents [

	<glmBrowser: 'Dashboard specifying extents' input: '100'>
	"self new dashboardWithSpecificExtents openOn: 100"
	
	|tmpBrowser|
	tmpBrowser := GLMDashboard new.
	tmpBrowser rigidStrategy.
	tmpBrowser addPaneNamed: #first extent: 300@200.
	tmpBrowser addPaneNamed: #second extent: 200@200.
	tmpBrowser addPaneNamed: #third extent: 200@300.
	tmpBrowser addPaneNamed: #fourth extent: 300@300.
	tmpBrowser addPaneNamed: #fifth extent: 150@350.
	
	tmpBrowser transmit to: #first; andShow: [:a |
		a list
			display: [:i | #(a b c d e)];
			yourself
		].
	tmpBrowser transmit to: #second; andShow: [:a |
		a list
			display: [:i | #(a b c d e)]
		].
	tmpBrowser transmit to: #third; andShow: [:a |
		a list
			display: [:i | #(a b c d e)]
		].
	tmpBrowser transmit to: #fourth; andShow: [:a |
		a list
			display: [:i | #(a b c d e)]
		].
	tmpBrowser transmit to: #fifth; andShow: [:a |
		a list
			display: [:i | #(a b c d e)]
		].
	^ tmpBrowser
]

{ #category : #browsers }
GLMBasicExamples >> dashboardsInDashboard [

	<glmBrowser: 'Dashboards in dashboard' input: '100'>
	"self new dashboard openOn: 100"
	
	|tmpBrowser|
	tmpBrowser := GLMDashboard new.
	tmpBrowser addPaneNamed: #dashboard.
	tmpBrowser addPaneNamed: #second.
	tmpBrowser addPaneNamed: #third.
	
	tmpBrowser transmit to: #dashboard; andShow: [:a |
		a custom: (self dashboard)
		].
	tmpBrowser transmit to: #second; andShow: [:a |
		a custom: (self dashboard)
		].
	tmpBrowser transmit to: #third; andShow: [:a |
		a custom: (self dashboard)
		].
	^ tmpBrowser
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
	"self new doubleClick openOn: 100"

	<glmBrowser: 'Double click' input: '100'>
	| browser |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two.
	browser
		transmit to: #one;
		andShow: [ :a | a list display: [ :x | 1 to: x ] ].
	browser
		transmit to: #two;
		from: #one port: #strongSelection;
		andShow: [:a |  a list display: [ :x | 1 to: x ] ].
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
GLMBasicExamples >> eyeseeBarDiagram [
	<glmBrowser: 'EyeSee interactive bar chart' input: '#(5 2 10 6 12 8)'>
	"self new eyeseeBarDiagram openOn: #(5 2 10 6 12 8)."
	| browser |

	browser := GLMTabulator new.
	browser row: #one span: 3; row: #two.
	browser transmit to: #one; andShow: [:a |
	       a eyesee
			title: 'Sample bar chart';
			diagram: [:renderer :x |
	                       renderer verticalBarDiagram
						y: #yourself;
						models: x;
						width: 200;
						height: 150;
						baseAxisLine.
					renderer interaction popupText: #yourself ]].
	browser transmit from: #one; to: #two; andShow: [:a | 
		a text
			title: 'Preview'].
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

{ #category : #composite }
GLMBasicExamples >> formatAsWords [
	"self new formatAsWords openOn: (1 to: 100)"
	<glmBrowser: 'Format' input: '(1 to: 100)'>	
	| browser |
	browser := GLMTabulator new.
	browser row: #list.
	browser showOn: #list; using: [
		browser tree
			format: [ :x | x asWords];
			display: [:x | x]].
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
GLMBasicExamples >> listsInDashboardWithUpdatedSelection [
	"self new listsWithUpdatedSelection openOn: 10"
	<glmBrowser: 'Updated selection in dashboard' input: '10'>
	| browser |
	browser := GLMDashboard new.
	browser addPaneNamed: #one; addPaneNamed: #two; addPaneNamed: #three.
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
GLMBasicExamples >> magritte [
	<glmBrowser: 'Magritte presentation' input: '''something'''>
	"self new magritte openOn: 'something'"
	| browser |
	browser := GLMTabulator new.
	browser row: #one.
	browser transmit to: #one; andShow:[ :a |
		a magritte
			title: 'Title';
			description: [:x | 
				| container |
				container := MAContainer new.
				container add: (
					MAStringDescription new
						label: 'Something';
						accessor: MAIdentityAccessor new;
						yourself).
				container ] ].
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
	<glmBrowser: 'Morph icons' input: 'GLMUIThemeExtraIcons class selectors select: [:each | (each beginsWith: ''glamorous'') and: [(GLMUIThemeExtraIcons perform: each) isForm ]]'>
	"self new morphIcons openOn: (GLMUIThemeExtraIcons class selectors select: [:each | (each beginsWith: 'glamorous') and: [(GLMUIThemeExtraIcons perform: each) isForm ]])"
	| browser |
	browser := GLMTabulator new.
	browser column: #list; column: #preview.
	browser title: 'Glamorous Icons'.
	browser showOn: #list; using: [
		browser list ].
	browser showOn: #preview; from: #list; using: [
		browser morph
			display: [:symbol | 
				(GLMUIThemeExtraIcons perform: symbol) asMorph ] ].
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
	<glmBrowser: 'Multiple actions' input: '''This example shows how multiple actions are rendered.'''>
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
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ];
			helpMessage:  'Enter a filtering request (e.g., "each > $f")'. 
	finder tree
			title: 'Tree';
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ];
			helpMessage:  'Enter a filtering request (e.g., "each > $f")'.
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
			filterOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each];
			helpMessage:  'Enter a filtering request (e.g., "each > 10")'.
	finder list
			title: 'With search';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			searchOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each];
			helpMessage:  'Enter a search request (e.g., "each > 10")'.
	^ finder 
]

{ #category : #text }
GLMBasicExamples >> populatePortAction [
	<glmBrowser: 'Populate port action' input: 'String withAll: ''Select a piece of text and open on the next pane via the contextual menu or by pressing Modifier+o. Otherwise just open the complete copy of the current text on the next pane via the menu or by pressing Modifier+l.'''>
	"self new populatePortAction openOn: 'Select a piece of text and open on the next pane either with the overall button, or via the context menu'"
	| browser |
	browser := GLMFinder new.
	browser text
		selectionPopulate: #selection on: $o entitled: 'Open selection on next pane' with: [:text | text selectedText ];
		populate: #selection icon: GLMUIThemeExtraIcons glamorousRight on: $l entitled: 'Open complete text on next pane' with: [:text | text text ].
	^ browser 
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

{ #category : #browsers }
GLMBasicExamples >> simpleFinder [
	<glmBrowser: 'Finder' input: '100'>
	"self new simpleFinder openOn: 100"
	| finder |	
	finder := GLMFinder new.
	finder list display: [ :x | 1 to: x ].
	^ finder
]

{ #category : #'actions examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	<glmBrowser: 'Browser menu' input: '$z'>
	"self new simpleFinderWithMenu openOn: $z"

	| finder |
	finder := GLMFinder new variableSizePanes.
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
	browser
		column: #tree;
		column: #browser span: 4.
	browser
		showOn: #tree;
		using: [ browser list ].
	accumulator := GLMAccumulator new.
	accumulator
		show: [ :a | 
			a title: [ :object | object printString ].
			a morph
				display: [ :object | 
					| model |
					" create omnibrowser model "
					model := object isBehavior
						ifTrue: [ OBHierarchyBrowser onClass: object ]
						ifFalse: [ OBImplementorsBrowser root: (OBSelectorNode on: object) ].	" create omnibrowser morph, but get rid of window "
					(PanelMorph new)
						layoutPolicy: ProportionalLayout new;
						addAllMorphs: (OBMorphBuilder build: model) paneMorphs;
						yourself ] ].
	(browser transmit)
		to: #browser;
		from: #tree port: #strongSelection;
		andShowIfNone: [ :a | a custom: accumulator ].
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
			dynamicActionsOnSelection: [:text | OrderedCollection with: (GLMGenericAction new title: 'Print selection'; action: [Transcript show: text selectedText]; yourself) ];
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

{ #category : #'tabs examples' }
GLMBasicExamples >> tabsWithDifferentActions [
	<glmBrowser: 'Tabs with different actions' input: 42>
	"self new tabsWithDifferentActions openOn: 42"
	
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [:a | 
		a text
			display: 'Tab with multiple actions. Switch between tabs to check the toolbars on the right';
			title: 'Tab with multiple actions';
			act: [:x | x inspect] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Inspect with icon';
			act: [:x | x printString inspect] icon: GLMUIThemeExtraIcons glamorousBrowse entitled: 'Print it and inspect with icon';
			act: [:x | x inspect] entitled: 'Inspect without icon';
			act: [:x | x printString inspect] entitled: 'Print it and inspect without icon'.
		a text 
			display: 'Tab without actions. Switch between tabs to check the toolbars on the right';
			title: 'Tab without actions' ].
	^ browser
]

{ #category : #'tabs examples' }
GLMBasicExamples >> tabsWithDifferentLabels [
	<glmBrowser: 'Tabs with different labels' input: '1'>
	"self new tabsWithDifferentLabels openOn: 1"
	
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
	<glmBrowser: 'Text ports' input: '''Type and select to see the results previewed.'''>
	"self new textPortsExamples openOn: 'Type and select to see the results previewed.'"

	| browser |
	browser := GLMTabulator new.
	browser
		row: #main;
		row: [ :r | r column: #selectionInterval; column: #selectedText; column: #full ].
	(browser transmit)
		to: #main;
		andShow: [ :a | a text ].
	(browser transmit)
		to: #selectionInterval;
		from: #main port: #selectionInterval;
		andShow: [ :a | a text title: '#selectionInterval port' ].
	(browser transmit)
		to: #selectedText;
		from: #main port: #selectedText;
		andShow: [ :a | a text title: '#selectedText port' ].
	(browser transmit)
		to: #full;
		from: #main port: #text;
		andShow: [ :a | a text title: '#text port'].
	^ browser
]

{ #category : #text }
GLMBasicExamples >> textSelection [
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
	"self new threeInterdependentPanes openOn: 5"

	<glmBrowser: 'Three inter-dependent panes' input: '5'>
	| browser |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two;
		column: #three.
	(browser transmit)
		to: #one;
		andShow: [ :a | a tree display: [ :x | 1 to: x ] ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | a tree display: [ :x | 1 to: x * 2 ] ].
	(browser transmit)
		to: #three;
		from: #two;
		andShow: [ :a | 
					(a tree)
						display: [ :x | 1 to: x * 3 ];
						populate: #focus
							on: $f
							entitled: 'Focus'
							with: [ :list | list selection ] ].
	(browser transmit)
		toOutside: #focus;
		from: #three port: #focus.
	(browser transmit)
		to: #one -> #selection;
		from: #outer port: #focus.
	(browser transmit)
		to: #two -> #selection;
		from: #outer port: #focus.
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
	"
		self new treeWithChildrenByLevel openOn: #(1 2 3 4 5)
	"

	<glmBrowser: 'Tree with children by level' input: '(1 to: 5)'>
	| browser |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: [ :c | 
					c
						row: #two;
						row: #three ].
	(browser transmit)
		to: #one;
		andShow: [ :a | 
					(browser tree)
						title: 'Tree';
						children: [ :item :x :level | 
									level > 1
										ifTrue: [ #() ]
										ifFalse: [ 1 to: item ] ]	"Children must return a collection" ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | a text title: 'Selection preview' ].
	(browser transmit)
		to: #three;
		from: #one port: #selectionPath;
		andShow: [ :a | a text title: 'Selection path preview' ].
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

	| browser |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: [ :c | 
					c
						row: #two;
						row: #three ].
	(browser transmit)
		to: #one;
		andShow: [ :a | 
					(a tree)
						title: 'first tree';
						children: [ :x | x value ].
					(a tree)
						title: 'second tree';
						children: [ :x | x value ] ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | browser text title: 'Selection preview' ].
	(browser transmit)
		to: #three;
		from: #one port: #selectionPath;
		andShow: [ :a | a text title: 'Selection path preview' ].
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

{ #category : #'explicit selection' }
GLMBasicExamples >> treeWithTags [
	<glmBrowser: 'Tree withTags' input: '(1 to: 10)'>
	"
		self new treeWithTags openOn: #(1 2 3 4 5 6 7 8 9 10)
	"
	|browser model|
	model := Dictionary new.
	model at: #some put: #(1 2 3 4).
	model at: #even put: #(2 6 8).
	model at: #odd put: #(3 7 9).
	
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		browser tree
			display: [model keys];  
			children: [:key | key isNumber ifFalse: [model at: key] ];
			tags: [:item | item isNumber ifTrue: [item even ifTrue: [#('even')] ifFalse: [#('odd')]] ifFalse: [#()]]].  
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> treeWithTagsMoreLevels [
	<glmBrowser: 'Tree withTags more levels' input: '(1 to: 10)'>
	"
		self new treeWithTagsMoreLevels openOn: #(1 2 3 4 5 6 7 8 9 10)
	"
	|browser model|
	model := Dictionary new.
	model at: #some put: #(1 2 3 4).
	model at: #even put: #(2 6 8).
	model at: #odd put: #(3 7 9).
	
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		browser tree
			display: [model keys];
			children: [:child | child isSymbol
								ifTrue: [Array with: ((model at: child) select: [:c | c < 4]) with: ((model at: child) select: [:c | c >= 4])]
								ifFalse: [child isCollection
											ifTrue: [child]
											ifFalse: [#()]]];
			tags: [:item | Array streamContents: [:stream |
					item isNumber ifTrue: [
						stream nextPut: (item even ifTrue: ['even'] ifFalse: ['odd']).
						stream nextPut: (item < 4 ifTrue: ['<4'] ifFalse: ['>=4' ])]]]].  
	^ browser
]

{ #category : #updating }
GLMBasicExamples >> updateableBrowser [
	<glmBrowser: 'Updateable browser' input: '|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new updateableBrowser openOn: collection."
	
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

{ #category : #browsers }
GLMBasicExamples >> validator [
	<glmBrowser: 'Validator' input: '100'>
	"self new validator openOn: 100"

	| finder validator |
	finder := GLMFinder new.
	validator := GLMValidator new.
	validator validator: 'Ok' act: [:x | ].
	validator show: [:a | a list display: [:x | 1 to: x ]].
	finder show: [:a | a custom: validator].
	^ finder
]

{ #category : #browsers }
GLMBasicExamples >> validatorDynamic [
	<glmBrowser: 'Dynamic validator' input: '100'>
	"self new validatorDynamic openOn: 100"

	| finder validator |
	finder := GLMFinder new.
	validator := GLMValidator new.
	validator validator: 'Ok' act: [:x | ].
	validator show: [:a | 
		a dynamic display: [:x |
			GLMListPresentation new display: [:y | 1 to: y]
			]  
		].
	finder show: [:a | a custom: validator].
	^ finder
]

{ #category : #browsers }
GLMBasicExamples >> wizard [
	<glmBrowser: 'Wizard' input: '100'>
	"self new wizard openOn: 100"

	| wizard |
	wizard := GLMWizard new.
	(wizard genericStep: #step)
		show: [:a | 
		a list
			display: [:list | 1 to: 100] 
		] ;
		name: 'Wizard pane';
		size: 2.
	^ wizard
]
