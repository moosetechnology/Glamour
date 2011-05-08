Class {
	#name : #GLMTabulatorMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMTabulatorMorphicTest >> testMultipleInitialSelection [
	| browser firstTreeMorph secondTreeMorph |
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
	firstTreeMorph := window submorphs last submorphs second submorphs first submorphs first.
	secondTreeMorph := window submorphs last submorphs last submorphs first submorphs first.
	self assert: firstTreeMorph model selection notNil.
	self assert: firstTreeMorph model selection selectedItemOrItemsOrNil size = 3.
	self assert: secondTreeMorph model selection isNil.
	self assert: (secondTreeMorph model roots collect: #item) asSet = firstTreeMorph model selection selectedItemOrItemsOrNil asSet
]

{ #category : #tests }
GLMTabulatorMorphicTest >> testSpawnTabulator [

	| browser |
	browser := GLMTabulator new.
	window := browser openOn: ($a to: $d).
	self assert: window model == browser.
	self repeatAssert: [
		window submorphs last 
					submorphs last 
						submorphs last 
							submorphs last class] equals: LazyMorphTreeMorph.

]

{ #category : #tests }
GLMTabulatorMorphicTest >> testStatusbar [
	| browser statusMorph |
	browser := GLMTabulator new.
	browser addStatusbar.
	browser row: #one.
	browser transmit to: #one; andShow: [:a | a list display: #(1 2 3)].
	window := browser openOn: 42.
	((browser paneNamed: #one) port: #status) value: 2.
	World doOneCycle.
	statusMorph := (window submorphs last: 2) first submorphs first.	
	self assert: (statusMorph isKindOf: LabelMorph).

"	detailsMorph := window submorphs last submorphs last submorphs first.
"
]
