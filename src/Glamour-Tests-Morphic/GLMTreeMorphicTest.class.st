Class {
	#name : #GLMTreeMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMTreeMorphicTest >> testChildrenBlock [

	| browser check treeMorph treeNodeMorph |
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

{ #category : #tests }
GLMTreeMorphicTest >> testChildrenBlockTakesEntity [

	| browser receivedEntity |
	browser := GLMFinder new.
	receivedEntity := nil.
	browser tree
		children: [:each :entity | receivedEntity := entity. #()].
	window := browser openOn: ($a to: $d).
	World doOneCycle.
	self repeatAssert: [receivedEntity] equals: ($a to: $d).

]

{ #category : #tests }
GLMTreeMorphicTest >> testTreeAllowDeseletion [
	| browser treeMorph treeNodeMorph |	
	browser := GLMFinder new.
	browser list allowDeselection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value isNil
]

{ #category : #tests }
GLMTreeMorphicTest >> testTreeDefaultAllowDeseletion [
	| browser treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: (browser panes first port: #selection) value = $a.
]

{ #category : #tests }
GLMTreeMorphicTest >> testTreeMultipleSelection [
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

{ #category : #tests }
GLMTreeMorphicTest >> testTreeMultipleSelectionWithCancellation [

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

{ #category : #tests }
GLMTreeMorphicTest >> testTreeSelection [

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

{ #category : #tests }
GLMTreeMorphicTest >> testTreeSelectionCancellation [

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

{ #category : #tests }
GLMTreeMorphicTest >> testTreeWithDisplay [
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

{ #category : #tests }
GLMTreeMorphicTest >> testTreeWithTags [
	|browser model treeMorph oddNode line3 oddTag someNode secondSome |
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
	window := browser openOn: model. 
	World doOneCycle.
	treeMorph := window submorphs last submorphs first submorphs first submorphs first.
	self assert: treeMorph class equals: LazyMorphTreeMorph.
	oddNode := treeMorph scroller submorphs second.	
	oddNode toggleExpandedState. 
	World doOneCycle.
	line3 := treeMorph scroller submorphs third.
	oddTag := line3 submorphs second submorphs first submorphs first submorphs second.
	oddTag doButtonAction.  
	World doOneCycle.
	someNode := treeMorph scroller submorphs first.
	someNode toggleExpandedState.
	World doOneCycle.
	secondSome := treeMorph scroller submorphs third submorphs second submorphs first submorphs first submorphs first.
	self assert: secondSome text asString equals: '3'.
]
