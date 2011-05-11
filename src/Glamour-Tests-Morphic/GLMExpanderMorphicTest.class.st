Class {
	#name : #GLMExpanderMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMExpanderMorphicTest >> testCreation [
	| browser |
	browser := GLMExpander new.
	browser show: [ :a | a text ].
	window := browser openOn: #(#a #b #c).
	self assert: window submorphs last class equals: LazyMorphTreeMorph.
	self assert: window submorphs last roots size equals: 3.
	self assert: window submorphs last roots first complexContents class equals: GLMExpanderLabelNodeModel.
	self assert: window submorphs last roots first complexContents contents size equals: 1.
	self
		assert: window submorphs last roots first complexContents contents first class
		equals: GLMExpanderContentsNodeModel
]
