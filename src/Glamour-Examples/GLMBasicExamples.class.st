"
self browseExamples
"
Class {
	#name : #GLMBasicExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
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
					(GLMAction new) 
						action: [:each | Transcript show: 'Menu - Item', i printString; cr]; 
						title: 'Menu - Item', i printString; 
						yourself ]
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
			actions: [:list | self actionsFor: list ].
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
			tags: [:each | 
				{ {MenuIcons perform: (each, 'Icon') asSymbol . each asString }}].
	
		browser tree
			title: 'Image Tags';
			tags: [:each | 
				{ MenuIcons perform: (each, 'Icon') asSymbol}].

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

{ #category : #others }
GLMBasicExamples >> fixSizePanes [
	"self new fixSizePanes openOn: 1"
	| browser |
	browser := GLMTabulator new.
	browser column: #fix size: 10; column: #variable.
	browser showOn: #fix; using: [browser text display: 'Fix size'].
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
GLMBasicExamples >> morphIcons [
	<glmBrowser: 'Morph icons' input: 'OBMorphicIcons selectors select: [:each | (OBMorphicIcons new perform: each) isForm ]'>
	"self new morphIcons openOn: (OBMorphicIcons selectors select: [:each | (OBMorphicIcons new perform: each) isForm ])"
	| browser |
	browser := GLMTabulator new.
	browser column: #list; column: #preview.
	browser title: 'OBMorphicIcons'.
	browser showOn: #list; using: [
		browser list ].
	browser showOn: #preview; from: #list; using: [
		browser morph
			display: [:symbol | 
				(OBMorphicIcons iconNamed: symbol) asMorph ] ].
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

{ #category : #'searching and filtering' }
GLMBasicExamples >> multipleFinderWithFilter [
	<glmBrowser: 'Filter' input: '$a to: $z'>
	"self new multipleFinderWithFilter openOn: ($a to: $z)"

	| finder |	
	finder := GLMFinder new.
	finder list
			title: 'List';
			beMultiple;
			actions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ].
	finder tree
			title: 'Tree';
			actions: [:list | self actionsFor: list];
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
			actions: [:list | self actionsFor: list].
	finder list
			title: 'With filter';
			beMultiple;
			actions: [:list | self actionsFor: list];
			filterOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each].
	finder list
			title: 'With search';
			beMultiple;
			actions: [:list | self actionsFor: list];
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

{ #category : #'actions examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	<glmBrowser: 'Browser menu' input: '$z'>
	"self new simpleFinderWithMenu openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			actions: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #others }
GLMBasicExamples >> simpleMondrianPainting [
	<glmBrowser: 'Mondrian painting' input: '100'>
	"self new simpleMondrianPainting openOn: 100"
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser mondrian 
			title: 'Numbers in Mondrian tree';
			painting: [:view :number | 
			view shape label.
			view nodes: (1 to: number).
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

{ #category : #table }
GLMBasicExamples >> simpleTable [
	<glmBrowser: 'Simple table' input: '100'>
	"self new simpleTable openOn: 1000"
	| finder |	
	finder := GLMFinder new.
	finder table
			display: [ :x | 1 to: x ]; 
			actions: [ :list | self actionsFor: list ];
			column: 'Number' evaluated: #asString;
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
				RectangleMorph new
					borderWidth: 0;
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
			actions: [:list | self actionsFor: list ];
			act: [Transcript show: 'static action'; cr] entitled: 'Static action';
			act: [Transcript show: 'static sub action'; cr] entitled: 'Static sub action' categorized: 'Sub menu'.
	finder text
			title: 'Text';
			display: [:each | 'Character ', each asString];
			actions: [:text | OrderedCollection with: (GLMAction new title: 'Print selection'; action: [Transcript show: text selection]; yourself) ];
			act: [Transcript show: 'Text static action'] entitled: 'Static action'.
	^ finder
]

{ #category : #'actions examples' }
GLMBasicExamples >> tableWithIcons [
	<glmBrowser: 'Icons' input: '($A to: $z)'>
	"self new tableWithIcons openOn: ($A to: $z)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser table
			column: 'Character' evaluated: [ :each | each asString ];
			column: 'ASCII' evaluated: [ :each | each asInteger printString ];
			act: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> taggedTree [
	"self new taggedTree openOn: #(1 2 3 4 5)"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			tags: [:each | 
				{each even ifTrue: ['even'] ifFalse: ['odd'].
				each even ifTrue: ['x'] ifFalse: ['y']}
				]].
	browser showOn: #two; from: #one; using: [
		browser text
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
	browser showOn: #main; using: [browser text].
	browser showOn: #selected; from: #main->#selectedText; using: [browser text].
	browser showOn: #full; from: #main->#text; using: [browser text].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> threeInterdependentPanes [
	<glmBrowser: 'Three inter-dependent panes' input: '5'>
	"self new threeInterdependentPanes openOn: 5"
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser tree
			display: [:x | 1 to: x]].
	browser showOn: #two; from: #one; using: [ 
		browser tree
			display: [:x | 1 to: x*2]].
	browser showOn: #three; from: #two; using: [
		browser tree
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus with: [:x | x ].
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | x ].
	browser sendTo: #two->#selection from: #outer->#focus with: [:x | x ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> treeWithAmountFiltering [
	<glmBrowser: 'Smart lists' input: '(1 to: 10000)'>
	"self new treeWithAmountFiltering openOn: (1 to: 10000)"
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			tags: [ :each | {each even printString} ];
			showOnly: 50 ].
	^ browser 
]

{ #category : #'actions examples' }
GLMBasicExamples >> treeWithExpansion [
	<glmBrowser: 'Tree with expansion' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))'>
	"self new treeWithExpansion openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			title: 'No expansion';
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ].
		browser tree
			title: 'Roots expanded';
			rootsExpanded;
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ].
		browser tree
			title: 'All expanded';
			allExpanded;
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser showOn: #two; from: #one; using: [ browser text ].
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
	browser showOn: #one; using: [
		browser tree
			title: 'first tree';
			children: [:x | x value ].
		browser tree
			title: 'second tree';
			children: [:x | x value ]].
	browser showOn: #two; from: #one; using: [ browser text title: 'Selection preview' ].
	browser showOn: #three; from: #one->#selectionPath; using: [ browser text title: 'Selection path preview'].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> treeWithMenu [
	<glmBrowser: 'Tree with menu' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j $l))'>
	"self new treeWithMenu openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j $l))"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ];
			act: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #updating }
GLMBasicExamples >> updatableBrowser [
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new updatableBrowser openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser act: [:b | b entity add: (browser entity size + 1) ] entitled: 'Add an item in the collection'.
	browser act: [:b | b entity removeLast ] entitled: 'Remove last item from the collection'.
	browser transmit to: #one; andShow: [ :a |
		a title: 'Updated automatically'.
		a stackedArrangement.
		a list title: 'List';
			shouldValidate: true;
			updateYourselfOn: GLMItemAdded from: #yourself;
			updateYourselfOn: GLMItemRemoved from: #yourself.
		a text title: 'Text';
			updateYourselfOn: GLMItemAdded from: #yourself;
			updateYourselfOn: GLMItemRemoved from: #yourself .
		a mondrian title: 'Mondrian';
			updateYourselfOn: GLMItemAdded from: #yourself;
			updateYourselfOn: GLMItemRemoved from: #yourself;
			painting: [:view :entity | 
				view shape label.
				view nodes: entity ] ].
	browser transmit to: #two; andShow: [ :a |
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
