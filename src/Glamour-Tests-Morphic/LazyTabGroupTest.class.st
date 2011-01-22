Class {
	#name : #LazyTabGroupTest,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'tabs'
	],
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #'setup - tear down' }
LazyTabGroupTest >> setUp [
	tabs := LazyTabGroupMorph new.
	tabs addLazyPage: (PanelMorph new fillStyle: (SolidFillStyle color: Color red)) label: 'one'.
	tabs addLazyPage: (PanelMorph new fillStyle: (SolidFillStyle color: Color yellow)) label: (LabelMorph contents: 'two').
	window := tabs openInWindow.

]

{ #category : #'setup - tear down' }
LazyTabGroupTest >> tearDown [
	window ifNotNil: [window delete]
]

{ #category : #tests }
LazyTabGroupTest >> testIsRendered [
	self assert: tabs pages first isRendered not.
	tabs selectedPageIndex: 1.
	self assert: tabs pages first isRendered.
	self assert: tabs pages second isRendered not
]

{ #category : #tests }
LazyTabGroupTest >> testRemovePage [
	tabs removePage: tabs pages first.
	self assert: tabs pages size = 1
]

{ #category : #tests }
LazyTabGroupTest >> testSimpleCreation [
	self assert: tabs pages size = 2.
]
