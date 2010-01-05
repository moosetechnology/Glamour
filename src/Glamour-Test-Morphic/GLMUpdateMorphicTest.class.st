Class {
	#name : #GLMUpdateMorphicTest,
	#superclass : #TestCase,
	#instVars : [
		'announcer',
		'entity',
		'browser',
		'window',
		'treeMorph'
	],
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMUpdateMorphicTest >> expectedFailures [
	^ #(testInvalidateSelection)
]

{ #category : #testing }
GLMUpdateMorphicTest >> setUp [
	announcer := Announcer new.
	entity := OrderedCollection with: 1 with: 2 with: 3.
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser list 
			updateYourselfOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true ].
	browser showOn: #two; from: #one; using: [browser text].
	window := browser openOn: entity.
	treeMorph := window submorphs last submorphs second submorphs first submorphs first.

]

{ #category : #testing }
GLMUpdateMorphicTest >> tearDown [
	window delete
]

{ #category : #testing }
GLMUpdateMorphicTest >> testAdd [
	entity add: 4.
	announcer announce: TestAnnouncement.
	self assert: treeMorph model roots size = 4
]

{ #category : #testing }
GLMUpdateMorphicTest >> testInvalidateSelection [
	(browser panes first port: #selection) value: 3.
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: (browser panes first port: #selection) value isNil.
	self assert: treeMorph model selection selectedItemOrItemsOrNil isNil
]

{ #category : #testing }
GLMUpdateMorphicTest >> testRemove [
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: treeMorph model roots size = 2
]
