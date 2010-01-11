Class {
	#name : #GLMBrowserTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMBrowserTest >> testNoComposite [
	| browser |
	browser := GLMBrowser new.
	self assert: browser pane presentations size = 1.
	self assert: browser pane presentations first = browser.
]
