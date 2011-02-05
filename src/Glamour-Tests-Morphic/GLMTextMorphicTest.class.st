Class {
	#name : #GLMTextMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMTextMorphicTest >> testForSmalltalk [
	| browser textMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | a text forSmalltalk; display: '123456789'].
	window := browser openOn: 4.

	textMorph := window submorphs last submorphs first submorphs first.
	self assert: (textMorph isKindOf: GLMPluggableShoutMorph)
]

{ #category : #tests }
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

{ #category : #tests }
GLMTextMorphicTest >> testUnregisterFromAnnouncementsWhenUpdating [
	| browser announcingCollection numberOfExecutions |
	numberOfExecutions := 0.
	announcingCollection := GLMAnnouncingCollection new.
	browser := GLMTabulator new.
	browser column: #text.
	browser transmit to: #text; andShow: [:a |
		a text 
			updateOn: GLMItemAdded from: [announcingCollection];
			display: [ numberOfExecutions := numberOfExecutions + 1]].
	window := browser openOn: announcingCollection.
	1 to: 3 do: [:each | announcingCollection add: each.].
	self assert: numberOfExecutions  = 4 "it should not be 8"
]
