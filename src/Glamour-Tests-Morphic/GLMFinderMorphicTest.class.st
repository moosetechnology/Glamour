Class {
	#name : #GLMFinderMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMFinderMorphicTest >> testCreationVariableSize [
	window := GLMFinder new fixedSize: false; openOn: 123.
	self assert: window submorphs last class = GeneralScrollPane
]

{ #category : #tests }
GLMFinderMorphicTest >> testFixedSize [
	window := GLMFinder new openOn: 123.
	self assert: window submorphs last class = GLMPaneScroller.
]

{ #category : #tests }
GLMFinderMorphicTest >> testRemovingVariableSizePanes [
	| finder |
	finder := GLMFinder new fixedSize: false.
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
	finder := GLMFinder new fixedSize: false.
	window := finder openOn: #a.
	self assert: window submorphs last scrollTarget submorphs size = 2.
	finder entity: #b.
	self assert: window submorphs last scrollTarget submorphs size = 2
]
