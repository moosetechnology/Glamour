Class {
	#name : #GLMFinderMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMFinderMorphicTest >> expectedFailures [ 
	^ #(testFinderWithEmbeddedBrowser)
]

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
	window := (GLMFinder new)
		variableSizePanes;
		openOn: 123.
	self assert: window submorphs last class equals: GeneralScrollPane
]

{ #category : #tests }
GLMFinderMorphicTest >> testDefaultFixedSizePanes [
	| finder container |
	finder := GLMFinder new.
	window := finder openOn: 40.
	window width: 501.
	container := self find: TransformMorph in: window.
	self assert: container submorphs first width equals: window submorphs last width.
	(finder panes first port: #selection) value: 42.
	self assert: container submorphs size equals: 3.
	self
		assert: container submorphs first extent
		equals: container submorphs last extent.
	self assert: container submorphs first width <= (window submorphs last width / 2)
]

{ #category : #tests }
GLMFinderMorphicTest >> testFinderWithEmbeddedBrowser [

	| navigator finder tree1 tree2 |
	navigator := GLMTabulator new.
	navigator row: #content.
	navigator transmit to: #content; andShow: [:a | a list display: #allSuperclasses].
	navigator transmit from: #content; toOutsidePort: #selection.
	finder := GLMFinder new.
	finder show: [:a | a custom: navigator].

	window := finder openOn: String.
	(finder panes first port: #selection) value: Collection.
	
	self assert: finder panes first presentations first ~= finder panes last presentations first.

	tree1 := self find: MorphTreeMorph in: window submorphs last submorphs last submorphs first.
	tree2 := self findLast: MorphTreeMorph in: window submorphs last submorphs last submorphs last.
	self assert: tree1 notNil.
	self assert: tree2 notNil.
	self assert: tree1 ~= tree2.
	self assert: tree1 model glamourPresentation pane ~= tree2 model glamourPresentation pane.
	self assert: tree1 model glamourPresentation ~= tree2 model glamourPresentation.
]

{ #category : #tests }
GLMFinderMorphicTest >> testFixedSize [
	window := GLMFinder new openOn: 123.
	self assert: window submorphs last class equals: GLMPaneScroller
]

{ #category : #tests }
GLMFinderMorphicTest >> testMultiplePresentationsValidation [
	| browser |
	browser := GLMFinder new.
	browser list.
	browser text.
	window := browser openOn: ($a to: $d).
	(browser panes first port: #selection) value: $z.
	self assert: (browser panes first port: #selection) value equals: $z
]

{ #category : #tests }
GLMFinderMorphicTest >> testNoSelection [
	| browser treeMorph treeNodeMorph |
	browser := GLMFinder new.
	browser tree noSelection.
	window := browser openOn: ($a to: $d).
	treeMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	treeNodeMorph := treeMorph scroller submorphs first.
	self send: treeMorph mouseUpOnItem: treeNodeMorph.
	self assert: browser panes size equals: 1
]

{ #category : #tests }
GLMFinderMorphicTest >> testOneFixedSizePane [
	| finder |
	finder := GLMFinder new fixedSizePanes: 1.
	window := finder openOn: 40.
	self assert: window submorphs last submorphs first submorphs first width equals: window submorphs last width.
	(finder panes first port: #selection) value: 42.
	self assert: window submorphs last submorphs last submorphs size equals: 3.
	self
		assert: window submorphs last submorphs last submorphs first extent
		equals: window submorphs last submorphs last submorphs last extent.
	self assert: window submorphs last submorphs last submorphs first width equals: window submorphs last width
]

{ #category : #tests }
GLMFinderMorphicTest >> testRemovingVariableSizePanes [
	| finder |
	finder := GLMFinder new variableSizePanes.
	window := finder openOn: 40.
	self assert: window submorphs last scrollTarget submorphs size equals: 2.
	(finder panes first port: #selection) value: 41.
	self assert: window submorphs last scrollTarget submorphs size equals: 4.
	(finder panes first port: #selection) value: 42.
	self assert: window submorphs last scrollTarget submorphs size equals: 4.
	(finder panes second port: #selection) value: 43.
	self assert: window submorphs last scrollTarget submorphs size equals: 6.
	(finder panes first port: #selection) value: 44.
	self assert: window submorphs last scrollTarget submorphs size equals: 4
]

{ #category : #tests }
GLMFinderMorphicTest >> testRemovingVariableSizePanesWhenChangingEntity [
	| finder |
	finder := GLMFinder new variableSizePanes.
	window := finder openOn: #a.
	self assert: window submorphs last scrollTarget submorphs size equals: 2.
	finder entity: #b.
	self assert: window submorphs last scrollTarget submorphs size equals: 2
]

{ #category : #tests }
GLMFinderMorphicTest >> testSpawnFinder [
	| browser |
	browser := GLMFinder new.
	window := browser openOn: ($a to: $d).
	self repeatAssert: [window submorphs last class] equals: GLMPaneScroller.

]
