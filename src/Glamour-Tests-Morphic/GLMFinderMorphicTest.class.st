Class {
	#name : #GLMFinderMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMFinderMorphicTest >> testFixedSize [
	window := GLMFinder new openOn: 123.
	self assert: window submorphs last class = GLMPaneScroller.
]

{ #category : #tests }
GLMFinderMorphicTest >> testNoFixedSize [
	window := GLMFinder new fixedSize: false; openOn: 123.
	self assert: window submorphs last class = GeneralScrollPane
]
