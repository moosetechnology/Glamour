"
self browseExamples
"
Class {
	#name : #GLMBasicExamples,
	#superclass : #GLMExamples,
	#category : #'Glamour-Examples'
}

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

{ #category : #'actions examples' }
GLMBasicExamples >> browserWithToolbar [
	"self new browserWithToolbar openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder act: [:f | f inspect] icon: MenuIcons smallFindIcon entitled: 'Inspect'.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			actions: [:list | self actionsFor: list ].
	^ finder
]

{ #category : #others }
GLMBasicExamples >> fixSizePanes [
	"self new fixSizePanes openOn: 1"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #fix size: 10; column: #variable.
	browser showOn: #fix; using: [browser text display: 'Fix size'].
	browser showOn: #variable; using: [browser text display: 'Variable size'].
	^ browser 
]

{ #category : #others }
GLMBasicExamples >> interdependentPanes [
	<glmBrowser: 'Inter-dependent Panes' input: '5'>
	"self new interdependentPanes openOn: 5"
	|browser |

	browser := GLMTableLayoutBrowser new.
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
	| browser |
	browser := GLMTableLayoutBrowser new.
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

{ #category : #'explicit selection' }
GLMBasicExamples >> multiInitialSelection [
	"
		| browser |
		browser := self new multiInitialSelection.
		browser openOn: 5.
		(browser panes first port: #selection) value: #(2 5 3).
	"
	|browser |

	browser := GLMTableLayoutBrowser new.
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
	<glmBrowser: 'Multiple List with Menu and Search' input: '$a to: $z'>
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
	<glmBrowser: 'Multiple List with Menu and Search' input: '$a to: $z'>
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
	<glmBrowser: 'Multiple Tabs' input: '1'>
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
	"self new simpleActionList openOn: #(1 2 3)"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #one.
	browser showOn: #one; using: [
		browser actionList
			act: [:entity | Transcript show: entity ] entitled: 'Transcript';
			act: [:entity | entity inspect ] entitled: 'Inspect'].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	<glmBrowser: 'Finder with Menu' input: '$z'>
	"self new simpleFinderWithMenu openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder list
			title: 'List';
			display: [:each | $a to: each];
			actions: [:list | self actionsFor: list ].
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

	browser := GLMTableLayoutBrowser new.
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

	| browser |
	browser := GLMTableLayoutBrowser new.
	browser title: 'StarBrowser Light'.
	browser column: #tree; column: #browser span: 4.
	browser showOn: #tree; using: [ browser list ].
	browser showOn: #browser; from: #tree; using: [
		browser morph
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
	^ browser 
]

{ #category : #'actions examples' }
GLMBasicExamples >> staticAndDynamicMenu [
	<glmBrowser: 'Static and Dynamic Menu' input: '$z'>
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

{ #category : #others }
GLMBasicExamples >> taggedTree [
	<glmBrowser: 'Tagged Tree' input: '#(1 2 3 4 5)'>
	"self new taggedTree openOn: #(1 2 3 4 5)"
	|browser |

	browser := GLMTableLayoutBrowser new.
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
	browser := GLMTableLayoutBrowser new.
	browser row: #main; row: [:r | r column: #selected; column: #full].
	browser showOn: #main; using: [browser text].
	browser showOn: #selected; from: #main->#selectedText; using: [browser text].
	browser showOn: #full; from: #main->#text; using: [browser text].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> threeInterdependentPanes [
	<glmBrowser: 'Inter-dependent Panes' input: '5'>
	"self new threeInterdependentPanes openOn: 5"
	|browser |

	browser := GLMTableLayoutBrowser new.
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
			update: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus with: [:x | x ].
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | x ].
	browser sendTo: #two->#selection from: #outer->#focus with: [:x | x ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> treeWithAmountFiltering [
	"self new treeWithAmountFiltering openOn: (1 to: 100)"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			tags: [:each | {each even printString} ];
			showOnly: 50].
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

	browser := GLMTableLayoutBrowser new.
	browser column: #one; column: [:c | c row: #two; row: #three].
	browser showOn: #one; using: [
		browser tree
			title: 'first tree';
			children: [:x | x value ].
		browser tree
			title: 'second tree';
			children: [:x | x value ]].
	browser showOn: #two; from: #one; using: [ browser text ].
	browser showOn: #three; from: #one->#selectionPath; using: [ browser text ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> treeWithMenu [
	<glmBrowser: 'Tree with Menu' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j $l))'>
	"self new treeWithMenu openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j $l))"
	|browser |

	browser := GLMTableLayoutBrowser new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ];
			act: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> updatableBrowser [
	"|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1.
	collection add: 2.
	collection add: 3.

	self new updatableBrowser openOn: collection.
	collection inspect"
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser column: #test; column: #test2.
	browser 
		showOn: #test;
		using: [ browser list 
							updateYourselfOn: GLMItemAdded from: #yourself;
							updateYourselfOn: GLMItemRemoved from: #yourself ].
	browser showOn: #test2; from: #test;
			using: [browser list display: [:s | s]].

	^browser
]

{ #category : #text }
GLMBasicExamples >> updateAction [
	<glmBrowser: 'Update Action' input: 'String withAll: ''Select a piece of text and open on the next pane via the contextual menu or by pressing Modifier+o. Otherwise just open the complete copy of the current text on the next pane via the menu or by pressing Modifier+l.'''>
	"self new updateAction openOn: 'Select a piece of text and open on the next pane'"
	| browser |
	browser := GLMFinder new.
	browser text
		update: #selection on: $o entitled: 'Open selection on next pane' with: [:text | text selectedText ];
		update: #selection on: $l entitled: 'Open complete text on next pane' with: [:text | text text ].
	^ browser 
]
