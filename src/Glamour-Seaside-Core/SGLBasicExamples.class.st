Class {
	#name : #SGLBasicExamples,
	#superclass : #SGLExamples,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #accessing }
SGLBasicExamples class >> applicationUrl [
	^ 'glamour/basicExamples'
]

{ #category : #others }
SGLBasicExamples >> accumulator [
	"
		self new accumulator openOn: 42
	"
	<glmBrowser: 'Accumulator' input: '42'>
	| browser acc |
	browser := GLMTabulator new.
	acc := GLMAccumulator new.
	acc show: [:a | 
		a title: [:x | x asString].
		a list title: 'List'; display: [:x |1 to: x ]; showOnly: 10.
		a text title: 'Text'; display: [:x | 'This is an editor on ', x printString ].
		].
	browser column: [:c | c row: #one span: 4; row: #two]; column: #three; column: #four.
	browser transmit to: #one; andShow: [:a | 
		a list display: [:x | x to: 10 * x]; showOnly: 10].
	browser transmit from: #one; to: #two; andShow: [:a |
		a text display: [:x | 'You have selected ', x printString ]].
	browser transmit from: #one; to: #three; andShowIfNone: [:a |
		a custom: acc ].
	
	browser transmit from: #one; to: #three->#entityToSelect.
	browser transmit from: #three->#activeEntity; to: #one->#selection.
	
	browser transmit from: #three; to: #four; andShow: [ :a |
		a list display: [:x| 1 to: x]	].

	^ browser
	

]

{ #category : #others }
SGLBasicExamples >> allowNil [
	"
		self new allowNil openOn: 42
	"
	<glmBrowser: 'Allowing nil' input: '42'>
	^ GLMBasicExamples new allowNil
]

{ #category : #composite }
SGLBasicExamples >> differentComposites [
	"
		self new differentComposites openOn: (1 to: 100)
	"
	<glmBrowser: 'Composite arrangements' input: '(1 to: 100)'>
	^ GLMBasicExamples new differentComposites
]

{ #category : #others }
SGLBasicExamples >> listWithTags [
	"
		self new listWithTags openOn: (1 to: 103)
	"
	<glmBrowser: 'List with tags' input: '1 to: 103'>
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			showOnly: 30;
			tags: [:each | 
				{each even ifTrue: ['even'] ifFalse: ['odd'].
				(each\\3 == 0 ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
				(each\\4 == 0 ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
				(each\\5 == 0 ) ifTrue: ['div 5'] ifFalse: ['not div 5']}
				]].
	browser showOn: #two; from: #one; using: [
		browser text
			display: [:x | 'You have selected ', x printString ]].
	^ browser
	
]

{ #category : #'explicit selection' }
SGLBasicExamples >> listsWithUpdatedSelection [
	"
		self new listsWithUpdatedSelection openOn: 10
	"
	<glmBrowser: 'Updated selection' input: '10'>
	^ GLMBasicExamples new listsWithUpdatedSelection
]

{ #category : #others }
SGLBasicExamples >> mondrianPainting [
	"
		self new mondrianPainting openOn: 100
	"
	<glmBrowser: 'Mondrian painting' input: '100'>
	^ GLMBasicExamples new mondrianPainting
]

{ #category : #'tab examples' }
SGLBasicExamples >> multipleTabs [
	"
		self new multipleTabs openOn: 1
	"
	<glmBrowser: 'Tabs' input: '1'>
	^ GLMBasicExamples new multipleTabs
]

{ #category : #others }
SGLBasicExamples >> simpleFinder [
	"
		self new simpleFinder openOn: 100
	"
	<glmBrowser: 'Simple finder' input: '100'>
	| finder |
	finder := GLMFinder new.
	finder show: [ :a |
		a list 
			display: [:x | 1 to: x] ].
		
	^finder.
]

{ #category : #'actions examples' }
SGLBasicExamples >> staticAndDynamicMenu [
	"
		self new staticAndDynamicMenu openOn: $z
	"
	<glmBrowser: 'Menus' input: '$z'>
	^ GLMBasicExamples new staticAndDynamicMenu
]

{ #category : #others }
SGLBasicExamples >> taggedTree [
	"
		self new taggedTree openOn: #(1 2 3 4 5)
	"
	<glmBrowser: 'Tagged Tree' input: '#(1 2 3 4 5)'>
	^ GLMBasicExamples new taggedTree
]

{ #category : #text }
SGLBasicExamples >> textPortsExamples [
	"
		self new textPortsExamples openOn: 'Type and select to see the results previewed.'
	"
	<glmBrowser: 'Text ports' input: '''Type and select to see the results previewed.'''>
	^ GLMBasicExamples new textPortsExamples
]

{ #category : #text }
SGLBasicExamples >> textSelectionInterval [
	"
		self new textSelectionInterval openOn: (1 to: 100)
	"
	<glmBrowser: 'Text selection' input: '(1 to: 100)'>
	^ GLMBasicExamples new textSelectionInterval
]

{ #category : #others }
SGLBasicExamples >> threeInterdependentPanes [
	"
		self new threeInterdependentPanes openOn: 5
	"
	<glmBrowser: 'Three inter-dependent panes' input: '5'>
	|browser |

	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser tree
			title: 'Pane 1';
			display: [:x | 1 to: x]].
	browser showOn: #two; from: #one; using: [ 
		browser tree
			title: 'Pane 2';
			display: [:x | 1 to: x*2]].
	browser showOn: #three; from: #two; using: [
		browser tree
			title: 'Pane 3';
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus with: [:x | x ].
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | x ].
	browser sendTo: #two->#selection from: #outer->#focus with: [:x | x ].
	^ browser
]

{ #category : #accessing }
SGLBasicExamples >> title [
	^ 'BasicExamples'
]

{ #category : #others }
SGLBasicExamples >> treeWithAmountFiltering [
	"
		self new treeWithAmountFiltering openOn: (1 to: 10000)
	"
	<glmBrowser: 'Smart lists' input: '(1 to: 10000)'>
	^ GLMBasicExamples new treeWithAmountFiltering
]

{ #category : #'explicit selection' }
SGLBasicExamples >> treeWithChildrenByLevel [
	"
		self new treeWithChildrenByLevel openOn: #(1 2 3 4 5)
	"
	<glmBrowser: 'Tree with children by level' input: '(1 to: 5)'>
	^ GLMBasicExamples new treeWithChildrenByLevel
	
]

{ #category : #'actions examples' }
SGLBasicExamples >> treeWithExpansion [
	"
		self new treeWithExpansion openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))
	"
	<glmBrowser: 'Tree with expansion' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j ($l $m $n)))'>
	^ GLMBasicExamples new treeWithExpansion
]

{ #category : #others }
SGLBasicExamples >> treeWithLeafTags [
	"
		self new treeWithLeafTags openOn: #( (1 2 3 4) (5 6 7 (8 9) (10 11) ( (12 13) (13 15) ) ) (16 17 18  (19 20 21 22)) )
	"
	<glmBrowser: 'Tree with leaf tags' input: '#( (1 2 3 4) (5 6 7 (8 9) (10 11) ( (12 13) (13 15) ) ) (16 17 18  (19 20 21 22)) )'>
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			beMultiple;
			title: 'No expansion';
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ].
		browser tree
			title: 'All Expanded';
			allExpanded;
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #'actions examples' }
SGLBasicExamples >> treeWithMenu [
	"
		self new treeWithMenu openOn: #(($a $b $c $d) ($e $f) ($g $h $i $j $l))
	"
	<glmBrowser: 'Tree with menu' input: '#(($a $b $c $d) ($e $f) ($g $h $i $j $l))'>
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			title: ['Tree with menu'];
			children: [:x :i | x asString size > 1 ifTrue: [x] ifFalse: [OrderedCollection new] ];
			act: [:tree | tree inspect ] on: $i entitled: 'Inspect';
			icon: [:x | MenuIcons helpIcon ]].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]
