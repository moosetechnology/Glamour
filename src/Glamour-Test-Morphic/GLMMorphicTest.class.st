Class {
	#name : #GLMMorphicTest,
	#superclass : #TestCase,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMMorphicTest >> expectedFailures [
	^ #(testChildrenBlock testChildrenBlockTakesEntity testColumnBlockTakesEntity)
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

{ #category : #testing }
GLMMorphicTest >> testAllowNil [
	| browser presentationsChanged window detailsMorph |
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
	window delete

]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlock [

	| browser window check treeMorph mouseUp treeNodeMorph |
	browser := GLMFinder new.
	check := false.
	browser tree
		children: [:each | check := true. #()].
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self repeatAssert: [check] equals: true
]

{ #category : #testing }
GLMMorphicTest >> testChildrenBlockTakesEntity [

	| browser receivedEntity window |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser tree
		children: [:each :entity | receivedEntity := entity. #()].
	window := browser openOn: ($a to: $d).
	window delete.
	self repeatAssert: [receivedEntity] equals: ($a to: $d).

]

{ #category : #testing }
GLMMorphicTest >> testColumnBlockTakesEntity [

	| browser receivedEntity window |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser table
		column: 'Even' evaluated: [:each :entity | receivedEntity := entity. 'x'].
	window := browser openOn: (1 to: 5).
	window delete.
	self repeatAssert: [receivedEntity] equals: (1 to: 5).

]

{ #category : #testing }
GLMMorphicTest >> testListDoubleClick [

	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph.
	self send: treeMorph doubleClickWithShift: false onItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #strongSelection) value = $a.
]

{ #category : #testing }
GLMMorphicTest >> testListDoubleClickWithMultipleSelection [

	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree beMultiple.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	lastTreeNodeMorph := treeMorph scroller submorphs last.
	self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph.
	self send: treeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self send: treeMorph doubleClickWithShift: false onItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #strongSelection) value asSet = ($a to: $d) asSet.
]

{ #category : #testing }
GLMMorphicTest >> testMultipleInitialSelection [
	| browser firstTreeMorph secondTreeMorph window |
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
	window delete.
	firstTreeMorph := window submorphs last submorphs second submorphs first submorphs first.
	secondTreeMorph := window submorphs last submorphs last submorphs first submorphs first.
	self assert: firstTreeMorph model selection notNil.
	self assert: firstTreeMorph model selection selectedItemOrItemsOrNil size = 3.
	self assert: secondTreeMorph model selection isNil.
	self assert: (secondTreeMorph model roots collect: #item) = firstTreeMorph model selection selectedItemOrItemsOrNil
]

{ #category : #testing }
GLMMorphicTest >> testNoSelection [
	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree noSelection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self assert: browser panes size = 1
]

{ #category : #testing }
GLMMorphicTest >> testSpawnFinder [

	| browser window check |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	window delete.
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.

]

{ #category : #testing }
GLMMorphicTest >> testSpawnTableLayoutBrowser [

	| browser window check |
	browser := GLMTabulator new.
	window := browser openOn: ($a to: $d).
	window delete.
	self repeatAssert: [
		window submorphs last 
					submorphs last 
						submorphs last 
							submorphs last class] equals: LazyMorphTreeMorph.

]

{ #category : #testing }
GLMMorphicTest >> testTreeAllowDeseletion [
	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |	
	browser := GLMFinder new.
	browser list allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeDefaultAllowDeseletion [
	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #selection) value = $a.
]

{ #category : #testing }
GLMMorphicTest >> testTreeMultipleSelection [

	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMFinder new.
	browser tree beMultiple.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	lastTreeNodeMorph := treeMorph scroller submorphs last.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	window delete.
	self assert: (browser panes first port: #selection) value notNil.
	self assert: (browser panes first port: #selection) value asSet = ($a to: $d) asSet
]

{ #category : #testing }
GLMMorphicTest >> testTreeMultipleSelectionWithCancellation [

	| browser window treeMorph treeNodeMorph lastTreeNodeMorph |
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
	window delete.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeSelection [

	| browser window treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self assert: treeMorph class = LazyMorphTreeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #selection) value = $a
]

{ #category : #testing }
GLMMorphicTest >> testTreeSelectionCancellation [

	| browser window treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	window delete.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #testing }
GLMMorphicTest >> testTreeWithDisplay [
	|browser treeCollection |
	treeCollection := { #root1->{#child1->{} . #child2->{}} . #root2 ->{} }.
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			display: [:each | each value ];
			children: [:x | x value ] ].
	window := browser openOn: #something -> treeCollection.
	self assert: browser panes first presentations first displayValue == treeCollection.
	window delete
]

{ #category : #private }
GLMMorphicTest >> wait: maxWaitSeconds until: validateBlock evaluatesTo: expectedResult [
	"Evaluate validateBlock until it returns expectedResult or 
maxWaitSeconds have passed,
	 pausing between evaluations.  Return the last result of validateBlock 
value"

	| startTime result |
	startTime := Time secondClock.
	[result := validateBlock value = expectedResult] whileFalse:
			[Time secondClock - startTime > maxWaitSeconds ifTrue: [^result].
			(Delay forMilliseconds: 50) wait].
	^ result

]
