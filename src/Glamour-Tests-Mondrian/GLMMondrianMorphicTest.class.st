Class {
	#name : #GLMMondrianMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Mondrian'
}

{ #category : #testing }
GLMMondrianMorphicTest >> expectedFailures [
	^ #(testUnregisterFromAnnouncementsWhenUpdating)
]

{ #category : #testing }
GLMMondrianMorphicTest >> testFigureSelection [
	| browser canvas |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a mondrian painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	canvas announce: (MOElementSelection event: nil on: canvas root allNodes first).
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
GLMMondrianMorphicTest >> testUnregisterFromAnnouncementsWhenUpdating [
	| browser announcingCollection numberOfExecutions |
	numberOfExecutions :=0.
	announcingCollection := GLMAnnouncingCollection new.
	browser := GLMTabulator new.
	browser column: #mondrian.
	browser transmit to: #mondrian; andShow: [:a |
		a mondrian 
			updateOn: GLMItemAdded from: [announcingCollection];
			painting: [:view | numberOfExecutions := numberOfExecutions + 1 ]].
	window := browser openOn: announcingCollection.
	1 to: 3 do: [:each | announcingCollection add: each.].
	self assert: numberOfExecutions  = 4 "it should not be 8"
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
	canvas announce: (MOElementSelection event: nil on: canvas root allNodes first).
	self assert: (browser panes first port: #selection) value = $a.
	
	browser panes first presentations first update.
	canvas := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	canvas announce: (MOElementSelection event: nil on: canvas root allNodes last).
	self assert: (browser panes first port: #selection) value = $d.
	

]
