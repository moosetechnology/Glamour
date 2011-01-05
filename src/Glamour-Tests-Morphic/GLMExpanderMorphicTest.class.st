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
	window := browser openOn: #(a b c).
	self assert: window submorphs last class = LazyMorphTreeMorph.
	self assert: window submorphs last roots size = 3.
	self assert: window submorphs last roots first complexContents class = GLMExpanderLabelNodeModel.
	self assert: window submorphs last roots first complexContents contents size = 1.
	self assert: window submorphs last roots first complexContents contents first class = GLMExpanderContentsNodeModel 
]
