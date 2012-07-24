Class {
	#name : #GLMRoassalMorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Tests-Roassal'
}

{ #category : #tests }
GLMRoassalMorphicTest >> testCanvas [
	| browser roassalMorph |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a roassal view: [:view :input | view add: ROElement new]].
	window := browser openOn: 42.

	roassalMorph := self find: ROMorph in: window.
	self assert: (roassalMorph isKindOf: ROMorph)
]

{ #category : #tests }
GLMRoassalMorphicTest >> testRoassalPresentationConstructor [
	| composite |
	composite := GLMCompositePresentation new.
	composite roassal.
	self assert: composite presentations size = 1.
	self assert: (composite presentations anyOne isKindOf: GLMRoassalPresentation)
]

{ #category : #tests }
GLMRoassalMorphicTest >> testUpdate [
	| browser originalView newView |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a roassal painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	originalView := (self find: ROMorph in: window) view.
	browser panes first presentations first update.
	newView := (self find: ROMorph in: window) view.
	
	self assert: newView ~~ originalView

]
