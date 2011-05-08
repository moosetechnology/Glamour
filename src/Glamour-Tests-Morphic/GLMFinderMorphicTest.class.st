Class {
	#name : #GLMFinderMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMFinderMorphicTest >> testClose [
	| finder |
	finder := GLMFinder new.
	window := finder openOn: 123.
	self assert: window owner notNil.
	finder close.
	self assert: window owner isNil
]

{ #category : #tests }
GLMFinderMorphicTest >> testCreationVariableSize [
	window := GLMFinder new variableSizePanes; openOn: 123.
	self assert: window submorphs last class = GeneralScrollPane
]

{ #category : #tests }
GLMFinderMorphicTest >> testDefaultFixedSizePanes [
	| finder |
	finder := GLMFinder new.
	window := finder openOn: 40.

	self assert: window submorphs last submorphs first submorphs first width = (window submorphs last width).
	(finder panes first port: #selection) value: 42.

	self assert: window submorphs last submorphs first submorphs size = 3.
	self assert: window submorphs last submorphs first submorphs first extent = window submorphs last submorphs first submorphs last extent.
	self assert: window submorphs last submorphs first submorphs first width <= (window submorphs last width / 2)
]

{ #category : #tests }
GLMFinderMorphicTest >> testFixedSize [
	window := GLMFinder new openOn: 123.
	self assert: window submorphs last class = GLMPaneScroller.
]

{ #category : #tests }
GLMFinderMorphicTest >> testMultiplePresentationsValidation [
	| browser |
	browser := GLMFinder new.
	browser list.
	browser text.
	window := browser openOn: ($a to: $d).
	(browser panes first port: #selection) value: $z.
	self assert: (browser panes first port: #selection) value = $z
]

{ #category : #tests }
GLMFinderMorphicTest >> testNoSelection [
	| browser treeMorph treeNodeMorph  |
	browser := GLMFinder new.
	browser tree noSelection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: browser panes size = 1
]

{ #category : #tests }
GLMFinderMorphicTest >> testOneFixedSizePane [
	| finder |
	finder := GLMFinder new fixedSizePanes: 1.
	window := finder openOn: 40.

	self assert: window submorphs last submorphs first submorphs first width = (window submorphs last width).
	(finder panes first port: #selection) value: 42.

	self assert: window submorphs last submorphs last submorphs size = 3.
	self assert: window submorphs last submorphs last submorphs first extent = window submorphs last submorphs last submorphs last extent.
	self assert: window submorphs last submorphs last submorphs first width = (window submorphs last width).

]

{ #category : #tests }
GLMFinderMorphicTest >> testRemovingVariableSizePanes [
	| finder |
	finder := GLMFinder new variableSizePanes.
	window := finder openOn: 40.
	self assert: window submorphs last scrollTarget submorphs size = 2.
	(finder panes first port: #selection) value: 41.
	self assert: window submorphs last scrollTarget submorphs size = 4.
	(finder panes first port: #selection) value: 42.
	self assert: window submorphs last scrollTarget submorphs size = 4.
	(finder panes second port: #selection) value: 43.
	self assert: window submorphs last scrollTarget submorphs size = 6.
	(finder panes first port: #selection) value: 44.
	self assert: window submorphs last scrollTarget submorphs size = 4.

]

{ #category : #tests }
GLMFinderMorphicTest >> testRemovingVariableSizePanesWhenChangingEntity [
	| finder |
	finder := GLMFinder new variableSizePanes.
	window := finder openOn: #a.
	self assert: window submorphs last scrollTarget submorphs size = 2.
	finder entity: #b.
	self assert: window submorphs last scrollTarget submorphs size = 2
]

{ #category : #tests }
GLMFinderMorphicTest >> testSpawnFinder [
	| browser |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.

]
