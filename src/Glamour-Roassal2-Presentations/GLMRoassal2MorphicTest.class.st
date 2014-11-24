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
GLMRoassal2MorphicTest >> testMondrianViewBuilder [
	| composite |
	composite := GLMCompositePresentation new.
	composite roassal2 
					initializeView: [ RTMondrianViewBuilder new ];
					painting: [ :view | view nodes: (1 to: 42) ].
	window := composite openOn: 42.
	self assert: composite first view class = RTMondrianViewBuilder.
	self assert: composite first view view elements size = 42
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
		andShow: [ :a | a roassal2 painting: [ :view :input | 
			view addAll: (RTBox elementsOn: ($a to: input)).
			RTHorizontalLineLayout on: view elements ] ].
	window := browser openOn: $d.
	originalView := browser panes first presentations first view.
	self assert: (originalView elements detect: [ :each | each model = $b ]) center x equals: 17.5.
	browser panes first presentations first update.
	newView := browser panes first presentations first view.
	self assert: (newView elements detect: [ :each | each model = $b ]) center x equals: 17.5
]

{ #category : #tests }
GLMRoassal2MorphicTest >> testZoomingActionsWorkForMondrianBuilder [
	| composite |
	composite := GLMCompositePresentation new.
	composite roassal2 initializeView: RTMondrianViewBuilder new.
	window := composite openOn: 42.
	self assert: composite first actions size equals: 4.
	self shouldnt: (composite first actions first actOn: composite first) raise: Error.
	self shouldnt: (composite first actions second actOn: composite first) raise: Error
]

{ #category : #tests }
GLMRoassal2MorphicTest >> testZoomingActionsWorkForView [
	| composite |
	composite := GLMCompositePresentation new.
	composite roassal2.
	window := composite openOn: 42.
	self assert: composite first actions size equals: 4.
	self shouldnt: (composite first actions first actOn: composite first) raise: Error.
	self shouldnt: (composite first actions second actOn: composite first) raise: Error.
]
