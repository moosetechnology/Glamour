Class {
	#name : #GLMTreeMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMTreeMorphicTest >> testMultipleSelectionWithChange [
	| browser firstTreeMorph secondTreeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [:a | a list beMultiple; display: [:x | (x - 2 to: x) ]].
	window := browser openOn: 4.

	firstTreeMorph := window submorphs last submorphs first submorphs first submorphs first.
	treeNodeMorph := firstTreeMorph scroller submorphs first.
	lastTreeNodeMorph := firstTreeMorph scroller submorphs last.
	self send: firstTreeMorph mouseUpOnItem: treeNodeMorph.
	self send: firstTreeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self assert: (firstTreeMorph model selection selectedNodePathList collect: [:each | each first item]) =  #(2 3 4) asOrderedCollection.
	
	(browser pane port: #entity) value: 42.
	secondTreeMorph := window submorphs last submorphs first submorphs first submorphs first.
	treeNodeMorph := secondTreeMorph scroller submorphs first.
	lastTreeNodeMorph := secondTreeMorph scroller submorphs second.
	self send: secondTreeMorph mouseUpOnItem: treeNodeMorph.
	self send: secondTreeMorph mouseUpWithShift: true onItem: lastTreeNodeMorph.
	self assert: (secondTreeMorph model selection selectedNodePathList collect: [:each | each first item]) =  #(40 41) asOrderedCollection.
]

{ #category : #testing }
GLMTreeMorphicTest >> testMultipleSelectionWithChangeFromModel [
	| browser firstTreeMorph secondTreeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; showing: [:a | a list beMultiple; display: [:x | (x - 2 to: x) ]].
	window := browser openOn: 4.

	firstTreeMorph := window submorphs last submorphs first submorphs first submorphs first.
	self assert: (firstTreeMorph model roots collect: #item) = #(2 3 4).
	((browser paneNamed: #one) port: #selection) value: #(2 3).
	self assert: ((browser paneNamed: #one) port: #selection) value asOrderedCollection = #(2 3) asOrderedCollection.
	
	(browser pane port: #entity) value: 42.
	secondTreeMorph := window submorphs last submorphs first submorphs first submorphs first.
	self assert: (secondTreeMorph model roots collect: #item) = #(40 41 42).
	((browser paneNamed: #one) port: #selection) value: #(40 41).
	self assert: ((browser paneNamed: #one) port: #selection) value asOrderedCollection = #(40 41) asOrderedCollection.

	self assert: firstTreeMorph ~= secondTreeMorph
]

{ #category : #testing }
GLMTreeMorphicTest >> testTwoPanesMultipleSelectionWithChange [
	| browser treeMorphOne treeNodeMorph treeMorphTwo |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser transmit to: #one; showing: [:a |
		a list display: [:x | 1 to: x ]].
	browser transmit to: #two; from: #one; showing: [:a |
		a list beMultiple; display: [:x | (x * 10) to: (x * 10 + 4) ] ].
	browser transmit to: #three; from: #two; showing: [:a | a text ].
	window := browser openOn: 4.

	"we select 2 in the first pane"
	treeMorphOne := (window submorphs last submorphs at: 3) submorphs first submorphs first.
	treeNodeMorph := treeMorphOne scroller submorphs second.
	self send: treeMorphOne mouseUpOnItem: treeNodeMorph.

	"we select all in the second pane"
	treeMorphTwo := (window submorphs last submorphs at: 4) submorphs first submorphs first.
	treeNodeMorph := treeMorphTwo scroller submorphs first.
	self send: treeMorphTwo mouseUpOnItem: treeNodeMorph.
	treeNodeMorph := treeMorphTwo scroller submorphs second.
	self send: treeMorphTwo mouseUpWithShift: true onItem: treeNodeMorph.

	self assert: ((browser paneNamed: #two) port: #selection) value = #(20 21) asOrderedCollection.
	
	"we select 4 in the first pane"
	treeMorphOne := (window submorphs last submorphs at: 3) submorphs first submorphs first.
	treeNodeMorph := treeMorphOne scroller submorphs last.
	self send: treeMorphOne mouseUpOnItem: treeNodeMorph.

	"we select the first two in the second pane"
	treeMorphTwo := (window submorphs last submorphs at: 4) submorphs first submorphs first.
	self assert: (treeMorphTwo model roots collect: #item) = #(40 41 42 43 44).
	treeNodeMorph := treeMorphTwo scroller submorphs first.
	self send: treeMorphTwo mouseUpOnItem: treeNodeMorph.
	treeNodeMorph := treeMorphTwo scroller submorphs second.
	self send: treeMorphTwo mouseUpWithShift: true onItem: treeNodeMorph.

	self assert: ((browser paneNamed: #two) port: #selection) value = #(40 41) asOrderedCollection 
]
