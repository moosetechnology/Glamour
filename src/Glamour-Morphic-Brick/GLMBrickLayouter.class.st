"
A GLMBrickLayouter is Brick's brand new layout system.
It builds a graph where each Brick corresponds two nodes: WidthNode and HeightNode.  Each node can have 4 states:

1 - depends on parent 
2 - depends on children
3 - depends on itself
4 - depends on opposite node.

Layouter traverses graph from root WidthNode. Depending on state it behaves differently:

1)

2) 

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
