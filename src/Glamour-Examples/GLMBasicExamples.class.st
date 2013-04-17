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
	"When double-clicking on a number in the list, opens a new tab on the right side"
	(browser transmit)
		from: #one port: #strongSelection;
		to: #three;
		andShowIfNone: [ :a | a custom: acc ].
	"When a number is selected in the list and a corresponding tab already exists on the right side, select the tab"
	(browser transmit)
		from: #one;
		to: #three port: #entityToSelect.
	"When a tab is selected on the right side, select the equivalent line in the first pane"
	(browser transmit)
		from: #three port: #activeEntity;
		to: #one port: #selection.
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
	browser transmit to: #one; andShow: [ :a |
		a tree 
			display:[ :x| 1 to: x ];
			allowDeselection ].
	browser transmit to: #two; andShow: [ :a | 
		a tree 
			display: #(a b c);
			allowDeselection].
	browser transmit to: #details; from: #one; from: #two; andShow: [ :a |
		a text 
			display: [ :one :two | 'At least one is nil: ', one asString, '-', two asString];
			allowNil.
		a text 
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
	browser transmit to: #one; andShow: [ :a |
		a tree 
			display: #(1 2 3);
			allowDeselection ].
	browser transmit to: #two; andShow: [ :a | 
		a tree 
			display: #(a b c);
			allowDeselection].
	browser transmit to: #details; from: #one; from: #two; andShow: [ :a | 
		a text 
			display: [ :one :two | one asString, two asString];
			allowNil ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> browserWithToolbar [
	<glmBrowser: 'Toolbar' input: '''Browser with toolbar'''>
	"self new browserWithToolbar openOn: 'Browser with toolbar'"

	| wrapper |
	wrapper := GLMWrapper new.
	wrapper act: [:f | f inspect] icon: GLMUIThemeExtraIcons glamorousInspect on: $i entitled: 'Inspect with icon'.
	wrapper act: [:f | f inspect] on: $i entitled: 'Inspect without icon'.
	wrapper show: [:a | a text ].
	^ wrapper
]

{ #category : #others }
GLMBasicExamples >> compoundTaggedTree [
	<glmBrowser: 'Tags' input: '#(window help home)'>
	"self new compoundTaggedTree openOn: #(window help home)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a tree
			title: 'Combined Tags';
			tags: [:each | { {ThemeIcons perform: (each, 'Icon') asSymbol . each asString }}].
		a tree
			title: 'Image Tags';
			tags: [:each | { ThemeIcons perform: (each, 'Icon') asSymbol}].
		a tree
			title: 'Combined Tags - Filter by image';
			tags: [:each | 
				{ each == #help 
						ifTrue:[ {ThemeIcons smallDeleteIcon . 'no ok' } ] 
						ifFalse:[ {ThemeIcons smallOkIcon . each asString } ]} ];
			tagsFilter: [:each | 
				{ each == #help 
						ifTrue:[ ThemeIcons smallDeleteIcon ] ifFalse:[ ThemeIcons smallOkIcon ] } ].
		a tree
			title: 'Combined Tags - Filter by label';
			tags: [:each | 
				{ {ThemeIcons perform: (each, 'Icon') asSymbol.
					each == #help ifTrue:[ 'no ok' ] ifFalse:[ 'ok' ]}} ];
			tagsFilter: [:each | 
				{ each == #help ifTrue:[ 'no ok' ] ifFalse:[ 'ok' ] } ] ].
	^ browser
]

{ #category : #browsers }
GLMBasicExamples >> dashboard [

	<glmBrowser: 'Dashboard' input: '42'>
	"self new dashboard openOn: 42"
	
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

	<glmBrowser: 'Dashboard specifying extents' input: '42'>
	"self new dashboardWithSpecificExtents openOn: 42"
	
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

	<glmBrowser: 'Dashboards in dashboard' input: '42'>
	"self new dashboard openOn: 42"
	
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

{ #category : #others }
GLMBasicExamples >> diff [
	<glmBrowser: 'Diff' input: '#(#(abc def ghi) #(abc xyz))'>
	"self new diff openOn: #(#(abc def ghi) #(abc xyz))"
	| browser | 
	browser := GLMTabulator new.
	browser 
		row: [:r | r column: #one; column: #two];
		row: #diff.
	browser transmit to: #one; andShow: [ :a |
		a list 
			display: #first ].
	browser transmit to: #two; andShow: [ :a | 
		a list
			display: #second ].
	browser transmit to: #diff; from: #one; from: #two; andShow: [ :a | 
		a diff
			display: [ :one :two | {one asString . two asString}] ].
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
	"self new doubleClick openOn: 100"

	<glmBrowser: 'Double click' input: '100'>
	| browser |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two.
	browser
		transmit to: #one;
		andShow: [ :a | 
			a table display: [ :x | 1 to: x ]; 
				column: 'value' evaluated: #asString; 
				column: 'odd' evaluated: [:each | each odd asString ]].
	browser
		transmit to: #two;
		from: #one port: #strongSelection;
		andShow: [:a |  a list display: [ :x | 1 to: x ] ].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> dropDownList [
	"self new dropDownList openOn: 5"

	<glmBrowser: 'Drop-down' input: '5'>
	|browser |

	browser := GLMTabulator new.
	browser row: #one size: 30; row: #two.
	browser transmit to: #one; andShow: [:a |
		a dropDownList
			display: [:x | 1 to: x ];
			format: [:number | Text string: number printString attribute: TextColor red]].
	browser transmit from: #one; to: #two; andShow: [:a |
		a list
			display: [:x | 1 to: x * 2]].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> dropDownListWithInitialValue [
	"self new dropDownListWithInitialValue openOn: 5"

	<glmBrowser: 'Drop-down with initial value' input: '5'>
	|browser |

	browser := GLMTabulator new.
	browser row: #one  size: 30; row: #two.
	browser transmit to: #one; andShow: [:a |
		a dropDownList
			display: [:x | (1 to: x) + 10 ];
			selectedIndex: 2 ].
	browser transmit from: #one; to: #two; andShow: [:a |
		a list
			display: [:x | 1 to: x ]].
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

{ #category : #browsers }
GLMBasicExamples >> finderWithDifferentFirstPresentation [
	<glmBrowser: 'Finder with different first presentation' input: '1 to: 42'>
	"self new finderWithDifferentFirstPresentation openOn: (1 to: 42)"
	| finder |	
	finder := GLMFinder new.
	finder with: [:f |
		f
			showFirst: [:a | a list]; 
			show: [:a | a list display: [:x | 1 to: x]
			]].
	^ finder
]

{ #category : #others }
GLMBasicExamples >> fixSizePanes [
	<glmBrowser: 'Fix size pane' input: '5'>
	"self new fixSizePanes openOn: 1"
	| browser |
	browser := GLMTabulator new.
	browser row: #variable; row: #fix size: 20.
	browser transmit to: #fix; andShow: [ :a | a label display: 'Fix size'].
	browser transmit to: #variable; andShow: [ :a | a text display: 'Variable size'].
	^ browser 
]

{ #category : #composite }
GLMBasicExamples >> formatAsWords [
	"self new formatAsWords openOn: (1 to: 100)"
	<glmBrowser: 'Format' input: '(1 to: 100)'>	
	| browser |
	browser := GLMTabulator new.
	browser row: #list.
	browser transmit to: #list; andShow: [ :a |
		a tree
			format: [ :x | x asWords];
			display: [:x | x]].
	^ browser 
]

{ #category : #others }
GLMBasicExamples >> interdependentPanes [
	<glmBrowser: 'Two inter-dependent panes' input: '5'>
	"self new interdependentPanes openOn: 5"
	|browser |
	self flag: 'this example does not work'.
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a | 
		a list
			display: [:x | 1 to: x * 3]].
	browser transmit to: #two; from: #one; andShow: [ :a | 
		a list
			display: [:x | 1 to: x * 3]].
	browser transmit to: #one; from: #two; andShow: [ :a | 
		a list
			display: [:x | 1 to: x * 3]].
	^ browser
]

{ #category : #'drag and drop' }
GLMBasicExamples >> listDragAndDrop [
	"self new listDragAndDrop openOn: (1 to: 5) asOrderedCollection"
	| browser |
	browser := GLMTabulator new.
	browser column: #source; column: #target.
	browser transmit to: #source; andShow: [:a | 
		a list 
			title: 'Source';
			display: (1 to: 10);
			allowItemDrag: [:item :list | true ];
			transformDraggedItem: [:item :list | item + 100 ]
			].
	browser transmit to: #target; andShow: [:a |  
		a list
			title: 'Target'; 
			display: [:collection | collection ];
			allowDropOnItem: [:draggedObject :targetItem :list | draggedObject isNumber ];
			dropOnItem: [:draggedObject :targetItem :list | 
				list entity addLast: (targetItem + draggedObject).
				list update.
				true ]
			].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> listsInDashboardWithUpdatedSelection [
	"self new listsInDashboardWithUpdatedSelection openOn: 10"
	<glmBrowser: 'Updated selection in dashboard' input: '10'>
	| browser |
	browser := GLMDashboard new.
	browser addPaneNamed: #one; addPaneNamed: #two; addPaneNamed: #three.
	browser transmit to: #one; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x ]].
	browser transmit to: #two; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x + 2 ]].
	browser transmit to: #three; andShow: [ :a |
		a tree
			beMultiple;
			display: [:x | 1 to: x ]].
	browser transmit to: #two port: #selection; from: #one; transformed: [:x | x + 2].
	browser transmit to: #one port: #selection; from: #two; transformed: [:x | x - 2].
	browser transmit to: #three port: #selection; from: #two; transformed: [:x | (1 to: (x - 2)) ].
	^ browser
]

{ #category : #'explicit selection' }
GLMBasicExamples >> listsWithUpdatedSelection [
	"self new listsWithUpdatedSelection openOn: 10"
	<glmBrowser: 'Updated selection' input: '10'>
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser transmit to: #one; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x ]].
	browser transmit to: #two; andShow: [ :a | 
		a tree
			display: [:x | 1 to: x + 2 ]].
	browser transmit to: #three; andShow: [ :a |
		a tree
			beMultiple;
			display: [:x | 1 to: x ]].
	browser transmit to: #two port: #selection; from: #one; transformed: [:x | x + 2].
	browser transmit to: #one port: #selection; from: #two; transformed: [:x | x - 2].
	browser transmit to: #three port: #selection; from: #two; transformed: [:x | (1 to: (x - 2)) ].
	^ browser
]

{ #category : #others }
GLMBasicExamples >> magritte [
	<glmBrowser: 'Magritte presentation' input: 'GLMMagrittePersonExample sampleData'>
	"self new magritte openOn: GLMMagrittePersonExample sampleData"
	"GLMMagrittePersonExample sampleReset"  
	"note, sampleData is aGLMAnnouncingCollection"
	
	| browser listParentPrototype magritteParentPrototype |
	
	self flag: 'Not working from within examples browser'.
		
	browser := GLMTabulator new initialExtent: 600@300.
	browser column: #list; column: #detail.
	browser transmit to: #list ; andShow: 
	[ :a | 
		listParentPrototype := a list.   "this assignment is just for exploring the operation of the example"
		listParentPrototype  	
			format: [ :person | person name ] ;
			updateOn: GLMItemAdded from: [ GLMMagrittePersonExample sampleData ] ;
			updateOn: GLMItemRemoved from: [ GLMMagrittePersonExample sampleData ] ;
			act: [ :listPresentation :glmAC | 
					| newItem | 
					newItem := GLMMagrittePersonExample new name: 'New...'  .
					glmAC add: newItem beforeOrLast: listPresentation selection.
					listPresentation selection: newItem.
				]	icon: GLMUIThemeExtraIcons glamorousAdd 
					entitled: 'Add' ;
			act: [ :listPresentation :glmAC | 
					glmAC remove: listPresentation selection ifAbsent: []
				]	icon: GLMUIThemeExtraIcons glamorousRemove 
					entitled: 'Remove' .
	].

	browser transmit from: #list ; to: #detail ; andShow: 
	[ :a | 
		magritteParentPrototype := a magritte.   "this assignment is just for exploring the operation of the example"
		magritteParentPrototype 	
			title: 'Details';
			description: [:person | person magritteDescription] ;
			onAnswer: [ :person :presentation | browser update ] . 
	].

	"THE FOLLOWING ARE JUST FOR EXPLORING THE EXAMPLE"
	listParentPrototype 	
			act: [ :listPresentation | listParentPrototype inspect ]		
					entitled: 'Inspect parentPrototype (note the id in self)' ;
			act: [ :listPresentation | listPresentation inspect ]  					
					entitled: 'Inspect GLMListPresentation (note the id in parentPrototype)' ;
			act: [ :listPresentation | self halt. GLMMagrittePersonExample sampleReset. listPresentation update. ]   	
					entitled: 'Reset Data (need to load in a new browser)' ;
			act: [ :listPresentation :model | self halt.  browser . listParentPrototype . magritteParentPrototype ]   	
					entitled: 'Adhoc debug explore'.
	self flag: 'TODO: Get Reset Data to update current browser rather than having to open a new browser'.
					
	magritteParentPrototype	
			act: [ :magritte | magritte entity explore ] 			
					entitled: 'Explore entity';
			act: [ :magritte | 
					magritte inspect. 
					magritteParentPrototype inspect.
					self inform: 'Compare the ''GLMMagrittePresentation(id='' of self and parentPrototype of these two inspectors just opened.  Change list items then compare again.'.
				]	entitled: 'Inspect and compare parentPrototype' ;
			act: [ :magritte | magritte inspect ]  					
					entitled: 'Inspect current aGLMMagrittePresentation' ;
			act: [ :magritte :model :x3 | self halt . browser . listParentPrototype . magritteParentPrototype ]
					entitled: 'Adhoc debug explore' .
					
	^ browser
]

{ #category : #others }
GLMBasicExamples >> mondrianPainting [
	<glmBrowser: 'Mondrian painting' input: '42'>
	"self new mondrianPainting openOn: 42"
	| browser items |
	browser := GLMTabulator withStatusbar.
	items := 50.
	browser act: [:b | 
		items := 10.
		(b paneNamed: #one) presentations first update ] entitled: 'Update'.
	browser act: [:b | 
		(b paneNamed: #one) inspect ] entitled: 'Inspect'.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a mondrian 
			title: 'Numbers in Mondrian tree';
			painting: [:view :number | 
			view shape label.
			view nodes: (1 to: items ).
			view edgesFrom: [:x | x // 3 ].
			view horizontalTreeLayout ]].
	browser transmit to: #two; from: #one; andShow: [ :a |
		a mondrian 
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
	browser transmit to: #list; andShow: [ :a | 
		a list title: 'GLMUIThemeExtraIcons' ].
	browser transmit to: #preview; from: #list; andShow: [ :a |
		a morph
			title: [:symbol | symbol];
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
	browser transmit to: #one; andShow: [ :a |
		a tree
			beMultiple;
			display: [:x | 1 to: x * 3]].
	browser transmit to: #two; from: #one; andShow: [ :a |
		a list ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> multipleActions [
	<glmBrowser: 'Multiple actions' input: '''This example shows how multiple actions are rendered.'''>
	"self new multipleActions openOn: 'This example shows how multiple actions are rendered.'"
	|browser |
	browser := GLMTabulator new.
	browser act: [:b | b inspect ] on: $/ entitled: 'Global action with shortcut'.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a text 
			title: 'Example';
			selectionAct: [:text | text inspect ] on: $i entitled: 'Selection action';
			act: [:text | text inspect ] entitled: 'Action without icon';
			act: [:text | text inspect ] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Action with icon' ].
	^ browser
]

{ #category : #'searching and filtering' }
GLMBasicExamples >> multipleFinderWithFilter [
	<glmBrowser: 'Filter' input: '$a to: $z'>
	"self new multipleFinderWithFilter openOn: ($a to: $z)"

	| finder |	
	finder := GLMFinder new.
	finder show: [:a | 
		a list
			title: 'List';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ];
			helpMessage:  'Enter a filtering request (e.g., "each > $f")'. 
		a tree
			title: 'Tree';
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | Compiler evaluate: '| each | each := self. ', text for: each logged: false ];
			helpMessage:  'Enter a filtering request (e.g., "each > $f")' ].
	^ finder 
]

{ #category : #'searching and filtering' }
GLMBasicExamples >> multipleFinderWithFilterAndSearch [
	<glmBrowser: 'Search' input: '$a to: $z'>
	"self new multipleFinderWithFilterAndSearch openOn: (1 to: 100)"

	| finder |	
	finder := GLMFinder new.
	finder show: [:a | 
		a list
			beMultiple;
			title: 'Simple';
			dynamicActions: [:list | self actionsFor: list].
		a list
			title: 'With filter';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			filterOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each];
			helpMessage:  'Enter a filtering request (e.g., "each > 10")'.
		a list
			title: 'With search';
			beMultiple;
			dynamicActions: [:list | self actionsFor: list];
			searchOn: [:text :each | (Compiler evaluate: '[:each | ', text, ']') value: each];
			helpMessage:  'Enter a search request (e.g., "each > 10")' ].
	^ finder 
]

{ #category : #text }
GLMBasicExamples >> populatePortAction [
	<glmBrowser: 'Populate port action' input: 'String withAll: ''Select a piece of text and open on the next pane via the contextual menu or by pressing Modifier+o. Otherwise just open the complete copy of the current text on the next pane via the menu or by pressing Modifier+l.'''>
	"self new populatePortAction openOn: 'Select a piece of text and open on the next pane either with the overall button, or via the context menu'"
	| browser |
	browser := GLMFinder new.
	browser show: [:a | a text
		selectionPopulate: #selection on: $o entitled: 'Open selection on next pane' with: [:text | text selectedText ];
		populate: #selection icon: GLMUIThemeExtraIcons glamorousRight on: $l entitled: 'Open complete text on next pane' with: [:text | text text ]].
	^ browser 
]

{ #category : #text }
GLMBasicExamples >> populatePortActionsWithDifferentTargets [
	<glmBrowser: 'Populate port action with different targets' input: '$a to: $z'>
	"self new populatePortActionsWithDifferentTargets openOn: ($a to: $z)"
	| composer |
	composer := GLMCompositePresentation new.
	composer tabulator with: [:t | 
		t column: #index; column: [:c | c row: #recepient1; row: #recepient2].
		t transmit to: #index; andShow: [:a | 
			a list 
				selectionAct: [:list | (list pane port: #custom1) value: list selection ] on: $1 entitled: 'To recepient 1';
				selectionPopulate: #custom2 on: $2 entitled: 'To recepient 2' with: [:list | list selection ] ].
		t transmit from: #index port: #custom1; to: #recepient1; andShow: [:a | 
			a text title: 'Recepient 1'].
		t transmit from: #index port: #custom2; to: #recepient2; andShow: [:a | 
			a text title: 'Recepient 2'].
	].
	^ composer
]

{ #category : #others }
GLMBasicExamples >> roassalPainting [
	<glmBrowser: 'Roassal painting' input: '42'>
	"self new roassalPainting openOn: 42"
	| browser |
	browser := GLMTabulator withStatusbar.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a list 
			title: 'Select and trigger from menu';
			display: [:x | 1 to: x ];
			selectionAct: [:list | 
				| value |
				value := list selection * 10. "simulate some custom setup"
				(list pane port: #customSelection) value: value ] 
			entitled:  'Multiply by 10 and then send outside'
			].
	browser transmit to: #two; from: #one port: #customSelection; andShow: [ :a |
		a roassal 
			title: 'Numbers in Roassal';
			painting: [:view :number | 
				view shape label.
				view nodes: (1 to: number).
				view edgesFrom: [:each | each // 5 ].
				view treeLayout  ]].
	^ browser
]

{ #category : #roassal }
GLMBasicExamples >> roassalWithCustomHighlight [
	<glmBrowser: 'Roassal with custom highlight' input: '1 to: 42'>
	"self new roassalWithCustomHighlight openOn: (1 to: 42)"

	| browser |
	browser := GLMTabulator new .
	browser
		with: [:tabulator | 
			tabulator column: #index; column: #visualization.
			tabulator transmit to: #index; andShow: [:a | a list ].
			tabulator transmit to: #visualization; andShowIfNone:[ :a | 
				a roassal 
					painting: [:view :collection :roassal | 
						view shape label.
						view interaction on: ROMouseLeftClick do: [:ann | (roassal pane port: #selection) value: ann element model ].
						view nodes: collection.
						view gridLayout.
						roassal on: GLMContextChanged do: [:ann |
							ann property = #selection ifTrue: [
								ann oldValue ifNotNil: [
									ROUnhighlightElement on: (ann presentation view raw elementFromModel: ann oldValue)].
								ROHighlightElement on: (ann presentation view raw elementFromModel: ann value) color: Color red ]]]].
			tabulator transmit from: #index; to: #visualization port: #selection.
			tabulator transmit from: #visualization port: #selection; to: #index port: #selection.
	].
	^ browser
]

{ #category : #roassal }
GLMBasicExamples >> roassalWithMenu [
	<glmBrowser: 'Roassal with menu' input: '42'>
	"self new roassalWithMenu openOn: 42"

	| browser |
	browser := GLMTabulator withStatusbar.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a roassal 
			title: 'Numbers in Roassal';
			painting: [:view :number | 
				view shape label.
				view interaction 
					on: ROMouseClick do:  [ :event |  
						ROFocusView new on: event element view: view raw ].
				view nodes: (1 to: number).
				view edgesFrom: [:each | each // 5 ].
				view treeLayout.
				view addMenu: 'Zoom in' callBack: [ :stack | ROZoomInMove new on: stack firstView ].
				view addMenu: 'Zoom out' callBack: [ :stack | ROZoomOutMove new on: stack firstView ].
				  ]].
	^ browser
]

{ #category : #actionlist }
GLMBasicExamples >> simpleActionList [
	<glmBrowser: 'Action list' input: '#(1 2 3)'>	
	"self new simpleActionList openOn: #(1 2 3)"
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a actionList
			act: [:entity | entity inspect ] entitled: 'Inspect';
			act: [:entity | entity explore ] entitled: 'Explore'].
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
	<glmBrowser: 'Finder' input: '42'>
	"self new simpleFinder openOn: 42"
	| finder |	
	finder := GLMFinder new.
	finder show: [:a | a list display: [ :x | 1 to: x ]].
	^ finder
]

{ #category : #'actions examples' }
GLMBasicExamples >> simpleFinderWithMenu [
	<glmBrowser: 'Browser menu' input: '$z'>
	"self new simpleFinderWithMenu openOn: $z"

	| finder |
	finder := GLMFinder new variableSizePanes.
	finder show: [:a | a list
			title: 'List';
			display: [:each | $a to: each];
			dynamicActionsOnSelection: [:list | self actionsFor: list ]].
	^ finder
]

{ #category : #table }
GLMBasicExamples >> simpleTable [
	<glmBrowser: 'Simple table' input: '100'>
	"| f | 
	f := self new simpleTable.
	f openOn: 1000.
	(f panes first port: #selection) value: 1"
	| finder |	
	finder := GLMFinder new.
	finder show: [:a | 
		a table
			display: [ :x | 1 to: x ]; 
			dynamicActions: [ :list | self actionsFor: list ];
			column: [:x | 'Numbers from 1 to ', x asString] evaluated: #asString;
			column: 'Even' evaluated: [ :each | each even asString ];
			column: 'Odd' evaluated: [ :each | each odd asString ] ].
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
	browser transmit to: #one; andShow: [ :a |
		a tree
			display: [:x | 1 to: x];
			format: [:number | Text string: number printString attribute: TextColor red]].
	browser transmit to: #two; from: #one; andShow: [ :a |
		a list
			display: [:x | 1 to: x * 2]].
	^ browser
]

{ #category : #text }
GLMBasicExamples >> smalltalkCode [
	<glmBrowser: 'Smalltalk code' input: '''"Enter some Smalltalk code and then accept to preview the result."'''>
	"self new smalltalkCode openOn: ''"
	| browser |
	browser := GLMTabulator new.
	browser row: #code span: 2; row: #preview.
	browser transmit to: #code; andShow: [ :a | 
		a smalltalkCode 
			title: 'Smalltalk Code';
			populate: #acceptedCode icon: GLMUIThemeExtraIcons glamorousAccept on: $s entitled: 'Accept' with: [:text | text text ] ].
	browser transmit from: #code port: #acceptedCode; to: #preview; andShow: [ :a | 
		a text 
			title: 'Evaluated result';
			display: [:code | [Compiler evaluate: code ] on: Error do: ['Error']];
			act: [:text | text displayValue explore] icon: GLMUIThemeExtraIcons glamorousInspect entitled: 'Explore' ].
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> spawnBrowserActions [
	<glmBrowser: 'Spawn browser actions' input: '#(1 2 3 4)'>
	"self new spawnBrowserActions openOn: #(1 2 3 4)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a list
			title: 'Example'.
			].
	browser spawn: [:presentation |
				|tmpBrowser|
				tmpBrowser := GLMTabulator new row: #one; initialExtent: 200@200 ;yourself.
				tmpBrowser
					transmit to: #one ; andShow: [:b |
						b text
							display: [:input | input asString]
						].
				tmpBrowser startOn: presentation entity
				] entitled: 'Open in new browser'.
	^ browser
]

{ #category : #'actions examples' }
GLMBasicExamples >> spawnBrowserSelectionActions [
	<glmBrowser: 'Spawn browser selection actions' input: '#(1 2 3 4)'>
	"self new spawnBrowserSelectionActions openOn: #(1 2 3 4)"
	|browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a |
		a list
			title: 'Example';
			selectionSpawn: [:listPresentation |
				|tmpBrowser|
				tmpBrowser := GLMTabulator new row: #one; initialExtent: 100@100 ;yourself.
				tmpBrowser
					transmit to: #one ; andShow: [:b |
						b text
							display: [:input | input asString]
						].
				tmpBrowser startOn: listPresentation selection
				] entitled: 'Open in new browser'
			].
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

{ #category : #'actions examples' }
GLMBasicExamples >> staticAndDynamicMenu [
	<glmBrowser: 'Menus' input: '$z'>
	"self new staticAndDynamicMenu openOn: $z"

	| finder |
	finder := GLMFinder new.
	finder show: [ :a |
		a list
			title: 'List';
			display: [:each | $a to: each];
			dynamicActionsOnSelection: [:list | self actionsFor: list ];
			selectionAct: [self inform: 'static action'] entitled: 'Static action';
			selectionAct: [self inform: 'static sub action'] entitled: 'Static sub action' categorized: 'Sub menu'.
		a text
			title: 'Text';
			display: [:each | 'Character ', each asString];
			dynamicActionsOnSelection: [:text | OrderedCollection with: (GLMGenericAction new title: 'Print selection'; action: [text selectedText inspect ]; yourself) ];
			selectionAct: [self inform: 'Text static action'] entitled: 'Static action'].
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
			selectionAct: [:tree | tree selection inspect ] on: $i entitled: 'Inspect';
			icon: [:each | each asInteger odd 
						ifTrue: [ GLMUIThemeExtraIcons glamorousRedCircle ] 
						ifFalse: [ GLMUIThemeExtraIcons glamorousGreenCircle ] ]].
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
		finder show: [:a | 
			a text
				title: i printString;
				display: [:x | i printString].
			a text
				titleIcon: GLMUIThemeExtraIcons glamorousBrowse;
				display: [:x | i printString] ]
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
		browser := self new textSelection.
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
		toOutsidePort: #focus;
		from: #three port: #focus.
	(browser transmit)
		to: #one port: #selection;
		fromOutsidePort: #focus.
	(browser transmit)
		to: #two port: #selection;
		fromOutsidePort: #focus.
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
					(a tree)
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
		(browser panes first port: #selection) value: (browser panes first port: #entity) value first value first.
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
		andShow: [ :a | a text title: 'Selection preview' ].
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
			icon: [:x | GLMUIThemeExtraIcons glamorousGrayCircle ]].
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
		a tree
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
		a tree
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
	collection add: 1.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1.
	self new updateableBrowser openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #preview.
	browser 
		act: [:b | b entity add: (b entity size + 1). b update ] 	
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add an item in the collection'.
	browser 
		act: [:b | b entity removeLast. b update ] 
		icon: GLMUIThemeExtraIcons glamorousRemove
		entitled: 'Remove last item from the collection'.
	browser 
		updateOn: GLMItemAdded from: #yourself;
		updateOn: GLMItemRemoved from: #yourself.
	browser transmit to: #preview; andShow: [ :a |
		a list 
			title: [:collection | 'List: ', collection size printString ];
			when: [:collection | collection size > 1 ].
		a text title: 'Text'; 
			format: [:collection | 'Current collection: ', collection printString, '
Add more items to show the list'] ].
	^ browser
]

{ #category : #updating }
GLMBasicExamples >> updateableIndividualPresentations [
	<glmBrowser: 'Updateable individual presentations' input: '|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new updateableIndividualPresentations openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #automatic; column: #menu.
	browser 
		act: [:b | b entity add: (b entity size + 1) ] 	
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add an item in the collection'.
	browser 
		act: [:b | b entity removeLast ] 
		icon: GLMUIThemeExtraIcons glamorousRemove
		entitled: 'Remove last item from the collection'.
	browser 
		act: [:b | b update ] 
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update complete browser'.
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
			act: [:p | p update] 
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update'.
		a text title: 'Text';
			act: [:p | p update] 
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update'.
		a mondrian title: 'Mondrian';
			act: [:p | p update]
				icon: GLMUIThemeExtraIcons glamorousRefresh
				entitled: 'Update';
			painting: [:view :entity | 
				view shape label.
				view nodes: entity ] ].
	^ browser
]

{ #category : #updating }
GLMBasicExamples >> validatingPresentation [
	<glmBrowser: 'Validating presentation' input: '|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	collection'>
	"
	|collection|
	collection := GLMAnnouncingCollection new.
	collection add: 1; add: 2; add: 3.
	self new validatingPresentation openOn: collection."
	
	| browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [:a | 
		a list 
			title: 'List with port validation';
			shouldValidate: true;
			updateOn: GLMItemRemoved from: #yourself;
			updateOn: GLMItemAdded from: #yourself;
			act: [:list :all | all removeLast ] 
				icon: GLMUIThemeExtraIcons glamorousRemove 
				entitled: 'Remove last';
			act: [:list :all | all add: (all size + 1) ] 
				icon: GLMUIThemeExtraIcons glamorousAdd 
				entitled: 'Add last'. 
	 ].
	browser transmit from: #one; to: #two; andShow: [:a | 
		a text title: 'Preview' ].
	^ browser 

]

{ #category : #browsers }
GLMBasicExamples >> validator [
	<glmBrowser: 'Validator' input: '42'>
	"self new validator openOn: 42"

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
	<glmBrowser: 'Dynamic validator' input: '42'>
	"self new validatorDynamic openOn: 42"

	| finder validator |
	finder := GLMFinder new.
	validator := GLMValidator new.
	validator validator: 'Ok' act: [:x | ].
	validator show: [:a | 
		a dynamic display: [:x |
			GLMListPresentation new display: [:y | 1 to: y]
			] ].
	finder show: [:a | a custom: validator].
	^ finder
]

{ #category : #browsers }
GLMBasicExamples >> wizard [
	"<glmBrowser: 'Wizard' input: '100'>"
	"self new wizard inspect openOn: 100"

	| wizard |
	self flag: 'this example does not work in the example browser'.
	wizard := GLMWizard new.
	(wizard genericStep: #step)
		show: [:a | 
			a list
				display: [:list | 1 to: 100] ];
		name: 'Wizard pane';
		size: 2.
	^ wizard
]

{ #category : #browsers }
GLMBasicExamples >> wrapper [ 
	
	<glmBrowser: 'Wrapper' input: '1 to: 42'>
	"self new wrapper openOn: (1 to: 42)"
	
	| wrapper |
	wrapper := GLMWrapper new title: 'Wrapper'.
	wrapper show: [:a | a list title: 'List'. a text title: 'Text' ].
	^ wrapper
]
