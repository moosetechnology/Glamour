Class {
	#name : #GLMAccumulatorTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #testing }
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

{ #category : #testing }
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

{ #category : #testing }
GLMAccumulatorTest >> testPaneCreation [
	| accumulator presentation |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	accumulator entity: 41.
	self assert: accumulator panes size = 1.
	self assert: (accumulator panes first port: #entity) value = 41.
	self assert: accumulator panes first presentations first = presentation.
	accumulator entity: 42.
	self assert: accumulator panes size = 2.
	self assert: (accumulator panes first port: #entity) value = 41.
	self assert: (accumulator panes last port: #entity) value = 42.
	self assert: accumulator panes first presentations first = presentation.
	self assert: accumulator panes last presentations first = presentation.

]

{ #category : #testing }
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

{ #category : #testing }
GLMAccumulatorTest >> testPaneSelectedAnnouncement [
	| accumulator presentation annoumcementsCount |
	accumulator := GLMAccumulator new.
	presentation := GLMPresentation new.
	accumulator addPresentation: presentation.
	annoumcementsCount := 0.
	accumulator on: GLMPaneSelected do: [:ann | annoumcementsCount := annoumcementsCount + 1].
	1 to: 42 do: [ :i | accumulator entity: i ].
	self assert: annoumcementsCount = 0.
	1 to: 42 do: [ :i | accumulator entity: i ].
	self assert: annoumcementsCount = 42
]
