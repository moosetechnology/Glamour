Class {
	#name : #GLMMondrianMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMMondrianMorphicTest >> testFigureSelection [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a mondrian painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	canvas announce: (MOFigureSelection event: nil on: canvas root allNodes first).
	self assert: (browser panes first port: #selection) value = $a.
]

{ #category : #testing }
GLMMondrianMorphicTest >> testMondrian [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a mondrian painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	self assert: (canvas isKindOf: MOCanvas).
	self assert: (canvas root nodes size = 4)
]

{ #category : #testing }
GLMMondrianMorphicTest >> testSelection [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a mondrian painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	(browser panes first port: #selection) value: $e.
	self assert: (canvas root allNodes allSatisfy: [:each | each isSelected not]).

	(browser panes first port: #selection) value: $c.
	self assert: (canvas root deepFindNodeWithEntity: $c) isSelected.
	
	(browser panes first port: #selection) value: $d.
	self assert: (canvas root deepFindNodeWithEntity: $d) isSelected.
	self assert: (canvas root deepFindNodeWithEntity: $c) isSelected not.

]

{ #category : #testing }
GLMMondrianMorphicTest >> testUpdate [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a mondrian painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	canvas announce: (MOFigureSelection event: nil on: canvas root allNodes first).
	self assert: (browser panes first port: #selection) value = $a.
	
	browser panes first presentations first update.
	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	canvas announce: (MOFigureSelection event: nil on: canvas root allNodes last).
	self assert: (browser panes first port: #selection) value = $d.
	

]
