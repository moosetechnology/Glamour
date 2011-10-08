Class {
	#name : #GLMCompositePresentationTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMCompositePresentationTest >> testAdd [
	| composite |
	composite := GLMCompositePresentation new.
	composite add: GLMPresentation new.
	self assert: composite isEmpty not.
	self assert: composite presentations size equals: 1
]

{ #category : #tests }
GLMCompositePresentationTest >> testAddRaisesAnnouncement [
	| composite announcementCount pane |
	composite := GLMCompositePresentation new.
	pane := composite pane.
	announcementCount := 0.
	composite entity: 42.
	pane on: GLMMatchingPresentationsChanged do: [:ann | 
		announcementCount := announcementCount + 1 ].
	composite add: GLMPresentation new.
	self assert: announcementCount equals: 1
]

{ #category : #tests }
GLMCompositePresentationTest >> testAddSetsCorrectPane [
	| composite presentation |
	composite := GLMCompositePresentation new.
	presentation := GLMPresentation new.
	composite add: presentation.
	self assert: composite pane = presentation pane
]

{ #category : #'tests - composer' }
GLMCompositePresentationTest >> testCreateFinder [

	| show |
	show := GLMCompositePresentation new.
	show finder with: [:b | b show: [:a | a text ] ].
	self assert: show size = 1.
	self assert: (show first isKindOf: GLMFinder).
	show startOn: 42.
	self assert: show first panes size = 1.
	self assert: (show first panes first port: #entity) value = 42
]

{ #category : #'tests - composer' }
GLMCompositePresentationTest >> testCreateTabulator [

	| show |
	show := GLMCompositePresentation new.
	show tabulator with: [:b | b row: #one. b transmit to: #one; transformed: [:x | x + 1]; andShow: [:a | a text ] ].
	self assert: show size = 1.
	self assert: (show first isKindOf: GLMTabulator).
	show startOn: 41.
	self assert: show first panes size = 1.
	self assert: (show first panes first port: #entity) value = 42
]

{ #category : #tests }
GLMCompositePresentationTest >> testCreation [
	| composite |
	composite := GLMCompositePresentation new.
	self assert: composite isEmpty
]

{ #category : #tests }
GLMCompositePresentationTest >> testDefaultPane [
	| composite |
	composite := GLMCompositePresentation new.
	self assert: composite pane presentations = composite
]

{ #category : #tests }
GLMCompositePresentationTest >> testPane [
	| pane composite presentation |
	pane := GLMPane new.
	composite := GLMCompositePresentation new.
	presentation := GLMPresentation new.
	composite add: presentation.
	composite pane: pane.
	self assert: composite pane == pane.
	self assert: composite first pane == pane
]
