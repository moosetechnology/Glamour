"
A GLMRoassalMorphicTest is xxxxxxxxx.

"
Class {
	#name : #GLMRoassal2MorphicTest,
	#superclass : #GLMMorphicTest,
	#category : #'Glamour-Roassal2-Presentations'
}

{ #category : #tests }
GLMRoassal2MorphicTest >> testCanvas [
	| composer roassalMorph |
	composer := GLMCompositePresentation new.
	composer roassal2 painting: [:view :input | view add: RTElement new].
	window := composer openOn: 42.

	roassalMorph := self find: TRMorph in: window.
	self assert: (roassalMorph isKindOf: TRMorph)
]

{ #category : #tests }
GLMRoassal2MorphicTest >> testRoassalPresentationConstructor [
	| composite |
	composite := GLMCompositePresentation new.
	composite roassal2.
	self assert: composite presentations size equals: 1.
	self assert: (composite presentations anyOne isKindOf: GLMRoassal2Presentation)
]

{ #category : #tests }
GLMRoassal2MorphicTest >> testUpdateUsesNewView [
	| browser originalView newView |
	browser := GLMWrapper new.
	browser show: [ :a | 
		a roassal2 painting: [:view :roassal2 :input | view add: RTElement new ]].
	window := browser openOn: $d.

	originalView := (self find: TRMorph in: window) trachelCanvas.
	browser panes first presentations first update.
	newView := (self find: TRMorph in: window) trachelCanvas.
	
	self assert: newView ~~ originalView

]

{ #category : #tests }
GLMRoassal2MorphicTest >> testUpdateViewIsProperlyLaidOut [
	| browser originalView newView |
	browser := GLMTabulator new.
	browser column: #one.
	browser transmit
		to: #one;
		andShow: [ :a | a roassal painting: [ :view :input | view nodes: ($a to: input) ] ].
	window := browser openOn: $d.
	originalView := (self find: ROMorph in: window) view.
	self assert: (originalView elements detect: [ :each | each model = $b ]) bounds left equals: 20.
	browser panes first presentations first update.
	newView := (self find: ROMorph in: window) view.
	self assert: (newView elements detect: [ :each | each model = $b ]) bounds left equals: 20
]