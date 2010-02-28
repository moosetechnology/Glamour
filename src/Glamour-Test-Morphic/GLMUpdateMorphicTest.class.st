Class {
	#name : #GLMUpdateMorphicTest,
	#superclass : #GLMMorphicTest,
	#instVars : [
		'announcer',
		'entity',
		'browser',
		'treeMorph',
		'listMorph',
		'tableMorph'
	],
	#category : #'Glamour-Test-Morphic'
}

{ #category : #testing }
GLMUpdateMorphicTest >> setUp [
	announcer := Announcer new.
	entity := OrderedCollection with: 1 with: 2 with: 3.
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a list 
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true.
		a tree 
			children: #();
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true.
		a table
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true ].
	browser showOn: #two; from: #one; using: [browser text].
	window := browser openOn: entity.
	listMorph := (window submorphs last submorphs second submorphs first pageAt: 1) submorphs first.
	treeMorph := (window submorphs last submorphs second submorphs first pageAt: 2) submorphs first.
	tableMorph := (window submorphs last submorphs second submorphs first pageAt: 3) submorphs first.
]

{ #category : #testing }
GLMUpdateMorphicTest >> testAdd [
	entity add: 4.
	announcer announce: TestAnnouncement.
	self assert: listMorph model roots size = 4.
	self assert: treeMorph model roots size = 4.
	self assert: tableMorph model roots size = 4.

]

{ #category : #testing }
GLMUpdateMorphicTest >> testInvalidateSelection [
	(browser panes first port: #selection) value: 3.
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: (browser panes first port: #selection) value isNil.
	self assert: listMorph model selection isNil
]

{ #category : #testing }
GLMUpdateMorphicTest >> testRemove [
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: listMorph model roots size = 2.
	self assert: treeMorph model roots size = 2.
	self assert: tableMorph model roots size = 2.
]
