Class {
	#name : #GLMAccumulatorMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMAccumulatorMorphicTest >> testActiveEntity [
	| browser tabs |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	browser entity: $d.
	browser entity: $e.
	window := browser openOn: $d.
	tabs := window submorphs last.
	tabs selectedPageIndex: 1.
	tabs update: #selectedIndex.
	self assert: browser activeEntity = $d.
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testCreation [
	| browser |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	self assert: window submorphs last class = LazyTabGroupMorph.
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testListInside [
	| browser tabs firstTreeMorph |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: (tabs pageAt: 1) submorphs first submorphs first class = LazyMorphTreeMorph.
	firstTreeMorph := (tabs pageAt: 1) submorphs first submorphs first.
	self assert: ((firstTreeMorph roots collect: #complexContents) collect: #item) = ($a to: $d) asArray
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testPaneCreation [
	| browser tabs |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: tabs pages size = 1.
	browser entity: $c.
	self assert: tabs pages size = 2
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testSelectedTab [
	| browser tabs |
	browser := GLMAccumulator new.
	browser show: [:a | 
		a title: [:x | x asString ].
		a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: tabs selectedPageIndex = 1.
	browser entity: $c.
	self assert: tabs selectedPageIndex = 2.
	browser entity: $d.
	self assert: tabs selectedPageIndex = 1
]

{ #category : #tests }
GLMAccumulatorMorphicTest >> testTabTitle [
	| browser tabs firstTabLabel |
	browser := GLMAccumulator new.
	browser show: [:a | 
		a title: [:x | x asString ].
		a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	firstTabLabel := tabs tabSelectorMorph submorphs first submorphs first submorphs first.
	self assert: firstTabLabel contents = 'd'.
]
