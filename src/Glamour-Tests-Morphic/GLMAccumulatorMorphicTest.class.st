Class {
	#name : #GLMAccumulatorMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMAccumulatorMorphicTest >> testActiveEntity [
	| browser tabs |
	browser := GLMAccumulator new.
	browser show: [ :a | a list display: [ :x | $a to: x ] ].
	browser entity: $d.
	browser entity: $e.
	window := browser openOn: $d.
	tabs := window submorphs last.
	browser entity: $c.
	tabs selectedPageIndex: 1.
	tabs update: #selectedIndex.
	self assert: browser activeEntity equals: $d
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testCloseTab [
	| browser tabs |
	browser := GLMAccumulator new.
	browser
		show: [ :a | 
			a title: [ :x | x asString ].
			a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	browser entity: $c.
	tabs := window submorphs last.
	self assert: browser panes size equals: 2.
	self assert: tabs pageMorphs size equals: 2.
	tabs removePageIndex: 1.
	self assert: tabs pageMorphs size equals: 1.
	self assert: browser panes size equals: 1
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testCreation [
	| browser |
	browser := GLMAccumulator new.
	browser show: [ :a | a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	self assert: window submorphs last class equals: LazyTabGroupMorph
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testListInside [
	| browser tabs firstTreeMorph |
	browser := GLMAccumulator new.
	browser show: [ :a | a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: (tabs pageAt: 1) submorphs first submorphs first class equals: LazyMorphTreeMorph.
	firstTreeMorph := (tabs pageAt: 1) submorphs first submorphs first.
	self assert: ((firstTreeMorph roots collect: #complexContents) collect: #item) equals: ($a to: $d) asArray
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testPaneCreation [
	| browser tabs |
	browser := GLMAccumulator new.
	browser show: [ :a | a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: tabs pages size equals: 1.
	browser entity: $c.
	self assert: tabs pages size equals: 2
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testSelectedTab [
	| browser tabs |
	browser := GLMAccumulator new.
	browser
		show: [ :a | 
			a title: [ :x | x asString ].
			a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: tabs selectedPageIndex equals: 1.
	browser entity: $c.
	self assert: tabs selectedPageIndex equals: 2.
	browser entity: $d.
	self assert: tabs selectedPageIndex equals: 1
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testTabTitle [
	| browser tabs firstTabLabel |
	browser := GLMAccumulator new.
	browser
		show: [ :a | 
			a title: [ :x | x asString ].
			a list display: [ :x | $a to: x ] ].
	window := browser openOn: $d.
	tabs := window submorphs last.
	firstTabLabel := tabs tabSelectorMorph submorphs first submorphs first.
	self assert: (firstTabLabel isKindOf: PanelMorph).
	self assert: firstTabLabel submorphs size equals: 2.
	self assert: firstTabLabel submorphs first contents equals: 'd'.
	self assert: (firstTabLabel submorphs last isKindOf: MultistateButtonMorph)
]
