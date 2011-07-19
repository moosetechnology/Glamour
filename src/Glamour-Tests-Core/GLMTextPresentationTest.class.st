Class {
	#name : #GLMTextPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMTextPresentationTest >> testSelectedText [
	| presentation |
	presentation := GLMTextPresentation new.
	self assert: presentation selectedText equals: ''.
	presentation selectedTextBlock: [ 'selection' ].
	self assert: presentation selectedText equals: 'selection'
]
