Class {
	#name : #GLMTextMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMTextMorphicTest >> testMultipleSelectionWithChange [
	| browser textMorph textPresentation |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | a text display: '123456789'].
	window := browser openOn: 4.

	textMorph := window submorphs last submorphs first submorphs first submorphs first submorphs first.
	self assert: textMorph selection isEmpty.
	textPresentation := (browser paneNamed: #one) presentations first.
	textPresentation selectionInterval: (2 to: 5).
	self assert: textMorph selection asString = '2345'
]
