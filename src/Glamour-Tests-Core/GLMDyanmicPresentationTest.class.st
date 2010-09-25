Class {
	#name : #GLMDyanmicPresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #'as yet unclassified' }
GLMDyanmicPresentationTest >> testDefaultPresentation [
	| dynamic |
	dynamic := GLMDynamicPresentation new.
	dynamic entity: 42.
	dynamic transformation: [ :entity |
		GLMTextPresentation new ].
	self assert: dynamic currentPresentation presentations size = 1.
	self assert: (dynamic currentPresentation presentations first isKindOf: GLMTextPresentation).
	self assert: dynamic currentPresentation pane == dynamic pane
]

{ #category : #'as yet unclassified' }
GLMDyanmicPresentationTest >> testPresentationTransformation [
	| dynamic |
	dynamic := GLMDynamicPresentation new.
	dynamic entity: 42.
	dynamic presentationTransformation: [ :some :entity |
		(1 to: entity) do: [ :each |
			some text title: each asString ] ].
	self assert: dynamic currentPresentation presentations size = 42.
	self assert: dynamic currentPresentation pane == dynamic pane
]
