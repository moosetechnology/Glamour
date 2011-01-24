Class {
	#name : #GLMUpdateMorphicTest,
	#superclass : #GLMMorphicTest,
	#instVars : [
		'announcer',
		'entity',
		'browser',
		'treeMorph',
		'listMorph',
		'tableMorph',
		'listLabelMorph',
		'unupdatedListMorph'
	],
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMUpdateMorphicTest >> expectedFailures [
	^ #(testUpdatePresentationTitle)
]

{ #category : #tests }
GLMUpdateMorphicTest >> setUp [
	announcer := Announcer new.
	entity := OrderedCollection with: 1 with: 2 with: 3.
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a |
		a 
"			title: [:x | x printString ];"
			verticallyStackedArrangement.
		a list 
			title: [:x | x printString ];
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true.
		a tree 
			title: [:x | x printString ];
			children: #();
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true.
		a table
			title: [:x | x printString ];
			updateOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true.
		a text 
			updateOn: TestAnnouncement from: [ announcer ].
		a list 
			title: 'Not updated automatically';
			shouldValidate: true.
			 ].
	browser showOn: #two; from: #one; using: [browser text].
	window := browser openOn: entity.
	listLabelMorph := window submorphs last submorphs second submorphs first submorphs first tabSelectorMorph submorphs first submorphs first.
	listMorph := window submorphs last submorphs second submorphs first submorphs first submorphs first submorphs first submorphs first.
	treeMorph := window submorphs last submorphs second submorphs first submorphs second submorphs first submorphs first submorphs first.
	tableMorph := window submorphs last submorphs second submorphs first submorphs third submorphs first submorphs first submorphs first.
	unupdatedListMorph := window submorphs last submorphs second submorphs first submorphs last submorphs first submorphs first submorphs first.
]

{ #category : #tests }
GLMUpdateMorphicTest >> testAdd [
	entity add: 4.
	announcer announce: TestAnnouncement.
	self assert: listMorph model roots size = 4.
	self assert: treeMorph model roots size = 4.
	self assert: tableMorph model roots size = 4.

]

{ #category : #tests }
GLMUpdateMorphicTest >> testAddAndUpdateBrowserManually [
	entity add: 4.
	self assert: unupdatedListMorph model roots size = 3.
	browser update.
	self assert: unupdatedListMorph model roots size = 4.
	entity add: 5.
	browser panes first presentations update.
	self assert: unupdatedListMorph model roots size = 5.
]

{ #category : #tests }
GLMUpdateMorphicTest >> testAnnouncerUnregistration [
	| subscription |
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size = 4.
	browser entity: #($a $b).
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size = 4.
	browser entity: #($d).
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size = 4.
	browser entity: #().
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size = 4.
	browser unregisterFromAllAnnouncements.
	subscription := announcer instVarNamed: 'subscriptions'.
	self deny: (subscription includesKey: TestAnnouncement).
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty
]

{ #category : #tests }
GLMUpdateMorphicTest >> testInvalidateSelection [
	(browser panes first port: #selection) value: 3.
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: (browser panes first port: #selection) value isNil.
	self assert: listMorph model selection isNil
]

{ #category : #tests }
GLMUpdateMorphicTest >> testRemove [
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: listMorph model roots size = 2.
	self assert: treeMorph model roots size = 2.
	self assert: tableMorph model roots size = 2.
]

{ #category : #tests }
GLMUpdateMorphicTest >> testUpdateBrowserTitle [

	browser title: 'something'.
	browser update.
	self assert: window label = 'something'
]

{ #category : #tests }
GLMUpdateMorphicTest >> testUpdatePresentationTitle [

	browser panes first presentations first title: 'something'.
	browser panes first presentations first update.
	self assert: listLabelMorph contents = 'something'
]
