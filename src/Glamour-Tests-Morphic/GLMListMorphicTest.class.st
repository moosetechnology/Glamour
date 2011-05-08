Class {
	#name : #GLMListMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMListMorphicTest >> testListDoubleClick [

	| browser treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser show: [:a | a list ].
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpWithShift: false onItem: treeNodeMorph.
	self send: treeMorph doubleClickWithShift: false onItem: treeNodeMorph.
	self assert: (browser panes first port: #strongSelection) value = $a.
]

{ #category : #tests }
GLMListMorphicTest >> testListDoubleClickWithMultipleSelection [

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

{ #category : #tests }
GLMListMorphicTest >> testMultipleSelectionWithChange [
	| browser firstTreeMorph secondTreeMorph treeNodeMorph lastTreeNodeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [:a | a list beMultiple; display: [:x | (x - 2 to: x) ]].
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

{ #category : #tests }
GLMListMorphicTest >> testMultipleSelectionWithChangeFromModel [
	| browser firstTreeMorph secondTreeMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [:a | a list beMultiple; display: [:x | (x - 2 to: x) ]].
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

{ #category : #tests }
GLMListMorphicTest >> testTwoPanesMultipleSelectionWithChange [
	| browser treeMorphOne treeNodeMorph treeMorphTwo |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser transmit to: #one; andShow: [:a |
		a list display: [:x | 1 to: x ]].
	browser transmit to: #two; from: #one; andShow: [:a |
		a list beMultiple; display: [:x | (x * 10) to: (x * 10 + 4) ] ].
	browser transmit to: #three; from: #two; andShow: [:a | a text ].
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

{ #category : #tests }
GLMListMorphicTest >> testUpdateFromModel [
	| browser  treeMorphOne1 treeMorphTwo1 treeMorphOne2 treeMorphTwo2 |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [:a | a list display: [:x | (x - 3 to: x) ]].
	browser transmit to: #two; from: #one; andShow: [:a |
		a list display: [:x | x * 10 to: (x * 10 + 2)]].
	window := browser openOn: 4.

	treeMorphOne1 := window submorphs last submorphs second submorphs first submorphs first.
	self assert: (treeMorphOne1 model roots collect: #item) = #(1 2 3 4).
	((browser paneNamed: #one) port: #selection) value: 2.	
	treeMorphTwo1 := window submorphs last submorphs last submorphs first submorphs first.
	self assert: (treeMorphTwo1 model roots collect: #item) = #(20 21 22).

	browser entity: 8.

	treeMorphOne2 := window submorphs last submorphs second submorphs first submorphs first.
	self assert: (treeMorphOne2 model roots collect: #item) = #(5 6 7 8).
	self assert: treeMorphOne1 ~= treeMorphOne2.

	self assert: (window submorphs last submorphs last submorphs first submorphs) isEmpty.
	
	((browser paneNamed: #one) port: #selection) value: 5.	
	treeMorphTwo2 := window submorphs last submorphs last submorphs first submorphs first.
	self assert: (treeMorphTwo2 model roots collect: #item) = #(50 51 52).
	self assert: treeMorphTwo1 ~= treeMorphTwo2
]
