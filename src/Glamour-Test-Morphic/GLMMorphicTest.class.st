Class {
	#name : #GLMMorphicTest,
	#superclass : #TestCase,
	#instVars : [
		'window'
	],
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'setup - tear down' }
GLMMorphicTest >> expectedFailures [
	^ #(testInterdependentPanesShouldUpdateTheFocusTriggerPaneWithText)
]

{ #category : #private }
GLMMorphicTest >> repeatAssert: aBlock equals: aResult [

	self assert: (self wait: 0.5 until: aBlock evaluatesTo: aResult)
]

{ #category : #private }
GLMMorphicTest >> send: treeMorph doubleClickWithShift: aBoolean onItem: treeNodeMorph [
	| event |
	event:= MouseButtonEvent basicNew 
		setType: #mouseDown
		position: (treeNodeMorph bounds origin + (1@1))
		which: 4
		buttons: (aBoolean ifTrue: [8] ifFalse: [0])
		hand: (HandMorph new mouseFocus: treeNodeMorph; yourself)
		stamp: nil.
	treeMorph doubleClick: event
]

{ #category : #private }
GLMMorphicTest >> send: treeMorph mouseDownWithShift: aBoolean onItem: treeNodeMorph [
	| mouseUp |
	mouseUp := MouseButtonEvent basicNew 
		setType: #mouseDown
		position: (treeNodeMorph bounds origin + (1@1))
		which: 4
		buttons: (aBoolean ifTrue: [8] ifFalse: [0])
		hand: (HandMorph new mouseFocus: treeNodeMorph; yourself)
		stamp: nil.
	treeMorph mouseUp: mouseUp onMorph: treeNodeMorph.
]

{ #category : #private }
GLMMorphicTest >> send: treeMorph mouseUpOnItem: treeNodeMorph [
	^ self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph
]

{ #category : #private }
GLMMorphicTest >> send: treeMorph mouseUpWithShift: aBoolean onItem: treeNodeMorph [
	| mouseUp |
	mouseUp := MouseButtonEvent basicNew 
		setType: #mouseUp
		position: (treeNodeMorph bounds origin + (1@1))
		which: 4
		buttons: (aBoolean ifTrue: [8] ifFalse: [0])
		hand: (HandMorph new mouseFocus: treeNodeMorph; yourself)
		stamp: nil.
	treeMorph mouseUp: mouseUp onMorph: treeNodeMorph.
]

{ #category : #'setup - tear down' }
GLMMorphicTest >> tearDown [
	window ifNotNil: [window delete]
]

{ #category : #testing }
GLMMorphicTest >> testAllowNil [
	| browser presentationsChanged detailsMorph |
	browser := GLMTabulator new.
	browser 
		column: [: c | c row: #one; row: #two];
		column: #details.
	browser showOn: #one; using: [
		browser tree display: #(1 2 3)].
	browser showOn: #two; using: [
		browser tree display: #(a b c)].
	browser showOn: #details; from: #one; from: #two; using: [
		browser text 
			display: [ :one :two | one asString, two asString];
			allowNil ].
	window := browser openOn: 42.
	((browser paneNamed: #one) port: #selection) value: 2.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText = '2nil'.
	((browser paneNamed: #two) port: #selection) value: #c.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText = '2c'.
	((browser paneNamed: #one) port: #selection) value: nil.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText = 'nilc'.

]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlock [

	| browser check treeMorph mouseUp treeNodeMorph |
	browser := GLMFinder new.
	check := false.
	browser tree
		children: [:each | check := true. #()].
	window := browser openOn: ($a to: $d).
	World doOneCycle.
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self repeatAssert: [check] equals: true
	
]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlockTakesEntity [

	| browser receivedEntity |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser tree
		children: [:each :entity | receivedEntity := entity. #()].
	window := browser openOn: ($a to: $d).
	World doOneCycle.
	self repeatAssert: [receivedEntity] equals: ($a to: $d).

]

{ #category : #testing }
GLMMorphicTest >> testColumnBlockTakesEntity [

	| browser receivedEntity |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser table
		column: 'Even' evaluated: [:each :entity | receivedEntity := entity. 'x'].
	window := browser openOn: (1 to: 5).
	World doOneCycle.
	self repeatAssert: [receivedEntity] equals: (1 to: 5).

]

{ #category : #testing }
GLMMorphicTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPane [
	|browser treeMorphThree treeMorphThree2 |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three"; column: #four".
	browser transmit to: #one; andShow: [:a | a list display: [:x | 1 to: x]].
	browser transmit to: #two; from: #one; andShow: [:a | a list display: [:x | 1 to: x*2]].
	browser transmit to: #three; from: #two; andShow: [ :a |
		a list 
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
"	browser showOn: #four; from: #three; using: [browser text allowNil]."
	browser transmit to: #outer->#focus; from: #three->#focus.
	browser transmit to: #one->#selection; from: #outer->#focus; transformed: [:x | x + 1].
	browser transmit to: #two->#selection; from: #outer->#focus; transformed: [:x | x + 2].
	window := browser openOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.

	treeMorphThree := (window submorphs last submorphs at: 5) submorphs first submorphs first.

	((browser paneNamed: #three) port: #selection) value: 2.
	((browser paneNamed: #three) port: #focus) value: 1.

	self assert: ((browser paneNamed: #one) port: #entity) value = 5.
	self assert: ((browser paneNamed: #one) port: #selection) value = 2.
	self assert: ((browser paneNamed: #two) port: #entity) value = 2.
	self assert: ((browser paneNamed: #two) port: #selection) value = 3.
	self assert: ((browser paneNamed: #three) port: #entity) value = 3.
	self assert: ((browser paneNamed: #three) port: #selection) value isNil.

	treeMorphThree2 := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	self assert: treeMorphThree ~= treeMorphThree2
]

{ #category : #testing }
GLMMorphicTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPaneWithText [
	|browser treeMorphThree treeMorphThree2 |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three"; column: #four".
	browser transmit to: #one; andShow: [:a | a text display: [:x | 1 to: x]].
	browser transmit to: #two; from: #one; andShow: [:a | a text display: [:x | 1 to: x*2]].
	browser transmit to: #three; from: #two; andShow: [ :a |
		a text 
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
"	browser showOn: #four; from: #three; using: [browser text allowNil]."
	browser transmit to: #outer->#focus; from: #three->#focus.
	browser transmit to: #one->#selection; from: #outer->#focus; transformed: [:x | x + 1].
	browser transmit to: #two->#selection; from: #outer->#focus; transformed: [:x | x + 2].
	window := browser openOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.

	treeMorphThree := (window submorphs last submorphs at: 5) submorphs first submorphs first.

	((browser paneNamed: #three) port: #selection) value: 2.
	((browser paneNamed: #three) port: #focus) value: 1.

	self assert: ((browser paneNamed: #one) port: #entity) value = 5.
	self assert: ((browser paneNamed: #one) port: #selection) value = 2.
	self assert: ((browser paneNamed: #two) port: #entity) value = 2.
	self assert: ((browser paneNamed: #two) port: #selection) value = 3.
	self assert: ((browser paneNamed: #three) port: #entity) value = 3.
	self assert: ((browser paneNamed: #three) port: #selection) value isNil.

	treeMorphThree2 := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	self assert: treeMorphThree ~= treeMorphThree2
]

{ #category : #testing }
GLMMorphicTest >> testListDoubleClick [

	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph.
	self send: treeMorph doubleClickWithShift: false onItem: treeNodeMorph.
	self assert: (browser panes first port: #strongSelection) value = $a.
]

{ #category : #testing }
GLMMorphicTest >> testListDoubleClickWithMultipleSelection [

	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree beMultiple.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	lastTreeNodeMorph := treeMorph scroller submorphs last.
	self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph.
	self send: treeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self send: treeMorph doubleClickWithShift: false onItem: treeNodeMorph.
	self assert: (browser panes first port: #strongSelection) value asSet = ($a to: $d) asSet.
]

{ #category : #testing }
GLMMorphicTest >> testMultipleInitialSelection [
	| browser firstTreeMorph secondTreeMorph |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			beMultiple;
			display: [:x | 1 to: x * 3]].
	browser showOn: #two; from: #one; using: [
		browser list ].
	window := browser openOn: 5.
	(browser panes first port: #selection) value: #(2 5 3).
	firstTreeMorph := window submorphs last submorphs second submorphs first submorphs first.
	secondTreeMorph := window submorphs last submorphs last submorphs first submorphs first.
	self assert: firstTreeMorph model selection notNil.
	self assert: firstTreeMorph model selection selectedItemOrItemsOrNil size = 3.
	self assert: secondTreeMorph model selection isNil.
	self assert: (secondTreeMorph model roots collect: #item) asSet = firstTreeMorph model selection selectedItemOrItemsOrNil asSet
]

{ #category : #testing }
GLMMorphicTest >> testMultiplePresentationsValidation [
	| browser |
	browser := GLMFinder new.
	browser list.
	browser text.
	window := browser openOn: ($a to: $d).
	(browser panes first port: #selection) value: $z.
	self assert: (browser panes first port: #selection) value = $z
]

{ #category : #testing }
GLMMorphicTest >> testNoSelection [
	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree noSelection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: browser panes size = 1
]

{ #category : #testing }
GLMMorphicTest >> testSpawnFinder [
	| browser check |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.

]

{ #category : #testing }
GLMMorphicTest >> testSpawnTabulator [

	| browser check |
	browser := GLMTabulator new.
	window := browser openOn: ($a to: $d).
	self assert: window model == browser.
	self repeatAssert: [
		window submorphs last 
					submorphs last 
						submorphs last 
							submorphs last class] equals: LazyMorphTreeMorph.

]

{ #category : #testing }
GLMMorphicTest >> testStatusbar [
	| browser statusMorph |
	browser := GLMTabulator new.
	browser addStatusbar.
	browser row: #one.
	browser transmit to: #one; andShow: [:a | a list display: #(1 2 3)].
	window := browser openOn: 42.
	((browser paneNamed: #one) port: #status) value: 2.
	World doOneCycle.
	statusMorph := (window submorphs last: 2) first submorphs first.	
	self assert: (statusMorph isKindOf: LabelMorph).

"	detailsMorph := window submorphs last submorphs last submorphs first.
"
]

{ #category : #testing }
GLMMorphicTest >> testTreeAllowDeseletion [
	| browser treeMorph treeNodeMorph lastTreeNodeMorph |	
	browser := GLMFinder new.
	browser list allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeDefaultAllowDeseletion [
	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value = $a.
]

{ #category : #testing }
GLMMorphicTest >> testTreeMultipleSelection [
	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree beMultiple.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	lastTreeNodeMorph := treeMorph scroller submorphs last.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self assert: (browser panes first port: #selection) value notNil.
	self assert: (browser panes first port: #selection) value asSet = ($a to: $d) asSet
]

{ #category : #testing }
GLMMorphicTest >> testTreeMultipleSelectionWithCancellation [

	| browser treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree beMultiple allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	lastTreeNodeMorph := treeMorph scroller submorphs last.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeSelection [

	| browser treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value = $a
]

{ #category : #testing }
GLMMorphicTest >> testTreeSelectionCancellation [

	| browser treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeWithDisplay [
	| browser treeCollection |
	treeCollection := { #root1->{#child1->{} . #child2->{}} . #root2 ->{} }.
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			display: [:each | each value ];
			children: [:x | x value ] ].
	window := browser openOn: #something -> treeCollection.
	self assert: browser panes first presentations first displayValue == treeCollection
]

{ #category : #private }
GLMMorphicTest >> wait: maxWaitSeconds until: validateBlock evaluatesTo: expectedResult [
	"Evaluate validateBlock until it returns expectedResult or 
maxWaitSeconds have passed,
	 pausing between evaluations.  Return the last result of validateBlock 
value"

	| startTime result |
	startTime := Time millisecondClockValue // 1000.
	[result := validateBlock value = expectedResult] whileFalse:
			[Time secondClock - startTime > maxWaitSeconds ifTrue: [^result].
			(Delay forMilliseconds: 50) wait].
	^ result

]
