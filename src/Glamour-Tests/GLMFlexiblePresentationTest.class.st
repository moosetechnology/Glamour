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
	self assert: (browser panes first presentations first isKindOf: GLMFlexiblePresentation)
]
