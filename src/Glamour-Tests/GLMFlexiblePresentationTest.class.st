Class {
	#name : #GLMFlexiblePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMFlexiblePresentationTest >> testDefault [
	| browser |
	browser := GLMTableLayoutBrowser new.
	browser startOn: #(1 2 3).
	self assert: (browser panes first presentations first isKindOf: GLMFlexiblePresentation).
	browser startOn: 1.
	self assert: (browser panes first presentations first isKindOf: GLMFlexiblePresentation).
]

{ #category : #'as yet unclassified' }
GLMFlexiblePresentationTest >> testDynamic [
	| browser childBrowser |
	childBrowser := GLMFinder new.
	browser := GLMTableLayoutBrowser new.
	browser column: #one.
	browser showOn: #one; using: [
		browser custom: (GLMDynamicPresentation new display: [childBrowser]) ].
	browser startOn: 42.
	self assert: browser panes first presentations first currentPresentation == childBrowser.
	self assert: childBrowser pane == browser panes first 
]
