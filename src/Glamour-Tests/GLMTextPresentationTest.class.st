Class {
	#name : #GLMTextPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #testing }
GLMTextPresentationTest >> testSelectedText [
	| presentation |
	presentation := GLMTextPresentation new.
	self assert: (presentation selectedText = '').
	presentation selectedTextBlock: ['selection'].
	self assert: (presentation selectedText = 'selection')
]
