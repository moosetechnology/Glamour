Class {
	#name : #GLMAccumulatorMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #'as yet unclassified' }
GLMAccumulatorMorphicTest >> testCreation [
	| browser |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	self assert: window submorphs last class = LazyTabGroupMorph.
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
GLMAccumulatorMorphicTest >> testPaneCreation [
	| browser tabs firstTreeMorph |
	browser := GLMAccumulator new.
	browser show: [:a | a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	self assert: tabs pages size = 1.
	self assert: tabs lazyPages size = 1.
	browser entity: $c.
	self assert: tabs lazyPages size = 2
]

{ #category : #'as yet unclassified' }
GLMAccumulatorMorphicTest >> testTabTitle [
	| browser tabs firstTreeMorph firstTabLabel |
	browser := GLMAccumulator new.
	browser show: [:a | 
		a title: [:x | x asString ].
		a list display: [:x | $a to: x ]].
	window := browser openOn: $d.
	tabs := window submorphs last.
	firstTabLabel := tabs tabSelectorMorph submorphs first submorphs first.
	self assert: firstTabLabel contents = 'd'.
]
