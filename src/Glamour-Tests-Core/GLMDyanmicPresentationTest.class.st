Class {
	#name : #GLMDyanmicPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMDyanmicPresentationTest >> testCachedPresentation [
	| dynamic currentPresentation |
	dynamic := GLMDynamicPresentation new.
	dynamic entity: 42.
	dynamic transformation: [ :entity | GLMTextPresentation new ].
	currentPresentation := dynamic currentPresentation.

	self assert: dynamic cachedPresentation == currentPresentation
]

{ #category : #tests }
GLMDyanmicPresentationTest >> testDefaultPresentation [
	| dynamic |
	dynamic := GLMDynamicPresentation new.
	dynamic entity: 42.
	dynamic transformation: [ :entity | GLMTextPresentation new ].
	self assert: dynamic currentPresentation presentations size equals: 1.
	self assert: (dynamic currentPresentation presentations first isKindOf: GLMTextPresentation).
	self assert: dynamic currentPresentation pane == dynamic pane
]

{ #category : #tests }
GLMDyanmicPresentationTest >> testDirectEventsPropagationTransformation [
	| dynamic textPresentation counter |
	counter := 0.
	dynamic := GLMDynamicPresentation new.
	dynamic entity: '42'.
	dynamic display: [ :entity | textPresentation := GLMTextPresentation new ].
	
	"Build the presentation"
	dynamic currentPresentation.
	
	textPresentation announcer when: GLMContextChanged do: [ :ann |
		counter := counter + 1 ].
	dynamic outerPortEvent: (GLMPortEvent on: 1 previouslyValued: 2).
	
	self assert: counter equals: 1.
]

{ #category : #tests }
GLMDyanmicPresentationTest >> testIndirectEventsPropagationTransformation [
	| dynamic textPresentation counter |
	counter := 0.
	dynamic := GLMDynamicPresentation new.
	dynamic entity: '42'.
	dynamic display: [ :entity | textPresentation := GLMTextPresentation new ].
	"Build the presentation"
	dynamic currentPresentation.
	
	textPresentation announcer when: GLMContextChanged do: [ :ann |
		ann property = #selectionInterval
			ifTrue: [ counter := counter + 1 ] ].
	textPresentation selectionInterval: (1 to: 2).
	
	self assert: counter equals: 1.
]

{ #category : #tests }
GLMDyanmicPresentationTest >> testPresentationInitializationBlock [
	| dynamic count |
	count := 0.
	dynamic := GLMDynamicPresentation new.
	dynamic transformation: [ :entity | 
		GLMListPresentation new 
			initialize: [ :pres | 
				count := count +1.
				pres selection: 5 ] ].
	dynamic entity: (1 to: 42).
	self assert: count = 0.
	self assert: (dynamic currentPresentation presentations first selection = 5).
	self assert: count = 1
]

{ #category : #tests }
GLMDyanmicPresentationTest >> testPresentationTransformation [
	| dynamic |
	dynamic := GLMDynamicPresentation new.
	dynamic entity: 42.
	dynamic presentationTransformation: [ :some :entity | (1 to: entity) do: [ :each | some text title: each asString ] ].
	self assert: dynamic currentPresentation presentations size equals: 42.
	self assert: dynamic currentPresentation pane == dynamic pane
]
