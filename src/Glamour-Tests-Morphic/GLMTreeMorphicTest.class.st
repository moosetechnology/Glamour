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
