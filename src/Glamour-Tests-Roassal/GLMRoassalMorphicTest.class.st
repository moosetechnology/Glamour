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
		a roassal painting: [:view :input |  view raw add: ROElement new]].
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
GLMRoassalMorphicTest >> testUpdateUsesNewView [
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

{ #category : #tests }
GLMRoassalMorphicTest >> testUpdateViewIsProperlyLaidOut [
	| browser originalView newView |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit to: #one; andShow: [ :a | 
		a roassal painting: [:view :input | view nodes: ($a to: input)]].
	window := browser openOn: $d.

	originalView := (self find: ROMorph in: window) view.
	self assert: (originalView firstView elements detect: [:each | each model = $b]) bounds left = 20.
	browser panes first presentations first update.
	newView := (self find: ROMorph in: window) view.
	self assert: (newView firstView elements detect: [:each | each model = $b]) bounds left = 20
]
