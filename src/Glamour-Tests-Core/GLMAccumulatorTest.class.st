Class {
	#name : #GLMAccumulatorTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMAccumulatorTest >> testCopy [
	| accumulator presentation copiedAccumulator |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator transmit fromOutside: #selection; toOutside: #otherPort.
	copiedAccumulator := accumulator copy.
	self assert: copiedAccumulator transmissions size = 1.
	self assert: copiedAccumulator transmissions first ~~ accumulator transmissions first.
	self assert: copiedAccumulator transmissions first destination pane == copiedAccumulator pane.
	self assert: copiedAccumulator transmissions first origins first pane ~~ accumulator pane.
	self assert: copiedAccumulator transmissions first origins first pane == copiedAccumulator pane
]

{ #category : #tests }
GLMAccumulatorTest >> testCustomTransmissions [
	| accumulator presentation |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator transmit fromOutside: #selection; toOutside: #otherPort.
	accumulator startOn: 41.
	(accumulator panes first port: #selection) value: 42.
	self assert: (accumulator pane port: #otherPort) value = 42.
]

{ #category : #tests }
GLMAccumulatorTest >> testNoDuplicatePaneCreation [
	| accumulator presentation |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator entity: 41.
	self assert: accumulator panes size = 1.
	accumulator entity: 42.
	self assert: accumulator panes size = 2.
	accumulator entity: 41.
	self assert: accumulator panes size = 2
]

{ #category : #tests }
GLMAccumulatorTest >> testPaneAddedAnnouncement [
	| accumulator presentation annoumcementsCount |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	annoumcementsCount := 0.
	accumulator on: GLMPaneAdded do: [:ann | annoumcementsCount := annoumcementsCount + 1].
	1 to: 42 do: [ :i | accumulator entity: i ].
	self assert: annoumcementsCount = 42
]

{ #category : #tests }
GLMAccumulatorTest >> testPaneCreation [
	| accumulator presentation |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator entity: 41.
	self assert: accumulator panes size = 1.
	self assert: (accumulator panes first port: #entity) value = 41.
	self assert: accumulator panes first presentations first rootPrototype == presentation.
	accumulator entity: 42.
	self assert: accumulator panes size = 2.
	self assert: (accumulator panes first port: #entity) value = 41.
	self assert: (accumulator panes last port: #entity) value = 42.
	self assert: accumulator panes first presentations first rootPrototype = presentation.
	self assert: accumulator panes last presentations first rootPrototype = presentation.

]

{ #category : #tests }
GLMAccumulatorTest >> testPaneRemovedAnnouncement [
	| accumulator presentation annoumcementsCount |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	annoumcementsCount := 0.
	accumulator on: GLMPaneRemoved do: [:ann | annoumcementsCount := annoumcementsCount + 1].
	1 to: 42 do: [ :i | accumulator entity: i ].
	self assert: annoumcementsCount = 0.
	1 to: 42 do: [ :i | accumulator removePaneIndex: 1 ].
	self assert: annoumcementsCount = 42
]

{ #category : #tests }
GLMAccumulatorTest >> testPaneSelectedAnnouncement [
	| accumulator presentation annoumcementsCount otherAnnoumcementsCount |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	annoumcementsCount := 0.
	otherAnnoumcementsCount := 0.
	1 to: 42 do: [ :i | accumulator entity: i ].
	accumulator on: GLMPaneSelected do: [:ann | annoumcementsCount := annoumcementsCount + 1].
	accumulator on: GLMPaneAdded do: [:ann | otherAnnoumcementsCount := otherAnnoumcementsCount + 1].
	accumulator on: GLMPaneRemoved do: [:ann | otherAnnoumcementsCount := otherAnnoumcementsCount + 1].
	self assert: annoumcementsCount = 0.
	self assert: otherAnnoumcementsCount = 0.
	1 to: 42 do: [ :i | accumulator entityToSelect: i ].
	self assert: annoumcementsCount = 42.
	self assert: otherAnnoumcementsCount = 0.
]

{ #category : #tests }
GLMAccumulatorTest >> testPublishToOutside [
	| accumulator presentation |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator startOn: 41.
	(accumulator panes first port: #selection) value: 42.
	self assert: (accumulator pane port: #selection) value = 42
]

{ #category : #tests }
GLMAccumulatorTest >> testPublishToOutsideWhenEmbedded [
	| browser accumulator actualAccumulator |
	browser := GLMTabulator new.
	accumulator := GLMAccumulator new.
	accumulator addPresentation: GLMPresentation new.
	accumulator addTransmission: (GLMTransmission new
			addActiveOrigin: (GLMPresentationBoundPort new
								presentation: accumulator; 
								name: #selection; 
								yourself);
			destination: (GLMPresentationBoundPort new
								presentation: accumulator; 
								name: #anotherPort; 
								yourself);
			yourself).
	browser addColumn: #one.
	browser addTransmission: (GLMTransmission new 
			ensurePresentIfNoneStrategy;
			addActiveOrigin: (GLMPresentationBoundPort new
								presentation: browser; 
								name: #entity; 
								yourself);
			destination: ((browser paneNamed: #one) port: #entity);
			addPresentation: accumulator;
			yourself).
	browser startOn: 41.
	actualAccumulator := browser panes first presentations first.
	(actualAccumulator panes first port: #selection) value: 42.
	self assert: (actualAccumulator pane port: #selection) value = 42.
	self assert: (actualAccumulator pane port: #anotherPort) value notNil.
	self assert: (actualAccumulator pane port: #anotherPort) value = 42
]
