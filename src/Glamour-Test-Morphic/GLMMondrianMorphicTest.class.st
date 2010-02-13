Class {
	#name : #GLMMondrianMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMMondrianMorphicTest >> testMondrian [
	| browser textMorph textPresentation canvas |
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
	| browser textMorph textPresentation canvas |
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
