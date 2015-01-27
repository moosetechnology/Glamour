"
A GLMBrickLayouter is Brick's brand new layout system.
It builds a graph where each Brick corresponds two nodes: WidthNode and HeightNode.  Each node can have 4 states:

1 - depends on parent 
2 - depends on children
3 - depends on itself
4 - depends on opposite node.

Layouter traverses graph from root WidthNode. Depending on state it behaves differently:

1) If layouter meets node with state 1 it checks if its parent already positioned and its height or width calculated. Otherwise it returns to such node later as soon as it finished with parent. If node with state 1 has parent with state 2 a LayoutCycleException must be reaised.

2) If layouter meets node with state 2 it must skip it and continues traversing all children until all of them are not positioned. As soon as it happens it returns back to skipped node. In case any of children of node with state 2 has state 1 a LayoutCycleException must be reaised.

3) If layouter meets node with state 3 it immidiately calculates corresponding value and applies it. Then it checks if there is an unvisited child node. If yes moves to it, otherwise returns to parent node.

4) If layouter meets node with state 4 it swaps its working node to opposite and continues traversing. For WidthNode opposing node is HeightNode and for HeightNode it is WidthNode.  If both nodes have state 4 a LayoutCycleException must be raised.

Instance Variables
	rootHeightNode:		<Object>
	rootWidthNode:		<Object>

rootHeightNode
	- xxxxx

rootWidthNode
	- xxxxx

"
Class {
	#name : #GLMBrickLayouter,
	#superclass : #Object,
	#instVars : [
		'rootWidthNode',
		'rootHeightNode'
	],
	#category : #'Glamour-Morphic-Brick-Layouter'
}

{ #category : #examples }
GLMBrickLayouter class >> example [
	<example: 'Build Graph'>
	|rooBrick brick1 brick2 brick3 brick11 brick12 brick13 brick21 brick31 brick32|
	
	rooBrick := GLMBrick new.
	brick1 := GLMBrick new.
	brick2 := GLMBrick new.
	brick3 := GLMBrick new.
	brick11 := GLMBrick new.
	brick12 := GLMBrick new.
	brick13 := GLMBrick new.
	brick21 := GLMBrick new.
	brick31 := GLMBrick new.
	brick32 := GLMBrick new.
	
	rooBrick
		addBrickBack: brick1;
		addBrickBack: brick2;
		addBrickBack: brick3.
		
	brick1
		addBrickBack: brick11;
		addBrickBack: brick12;
		addBrickBack: brick13.
		
	brick2 addBrickBack: brick21.
	
	brick3
		addBrickBack: brick31;
		addBrickBack: brick32.
		
	^ self new buildGraphOn: rooBrick
]

{ #category : #building }
GLMBrickLayouter >> buildGraphOn: aBrick [

	self rootHeightNode: (GLMBrickLayouterHeightNode new brick: aBrick).
	self rootWidthNode: (GLMBrickLayouterWidthNode new brick: aBrick).
	self rootHeightNode opposite: self rootWidthNode.
	self rootHeightNode build.
]

{ #category : #accessing }
GLMBrickLayouter >> rootHeightNode [
	^ rootHeightNode
]

{ #category : #accessing }
GLMBrickLayouter >> rootHeightNode: anObject [
	rootHeightNode := anObject
]

{ #category : #accessing }
GLMBrickLayouter >> rootWidthNode [
	^ rootWidthNode
]

{ #category : #accessing }
GLMBrickLayouter >> rootWidthNode: anObject [
	rootWidthNode := anObject
]
