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
	self assert: listMorph model roots size equals: 4.
	self assert: treeMorph model roots size equals: 4.
	self assert: tableMorph model roots size equals: 4
]

{ #category : #tests }
GLMUpdateMorphicTest >> testAddAndUpdateBrowserManually [
	entity add: 4.
	self assert: unupdatedListMorph model roots size equals: 3.
	browser update.
	self assert: unupdatedListMorph model roots size equals: 4.
	entity add: 5.
	browser panes first presentations update.
	self assert: unupdatedListMorph model roots size equals: 5
]

{ #category : #tests }
GLMUpdateMorphicTest >> testAllowNil [
	| browser detailsMorph |
	browser := GLMTabulator new.
	browser
		column: [ :c | 
					c
						row: #one;
						row: #two ];
		column: #details.
	browser
		showOn: #one;
		using: [ browser tree display: #(1 2 3) ].
	browser
		showOn: #two;
		using: [ browser tree display: #(#a #b #c) ].
	browser
		showOn: #details;
		from: #one;
		from: #two;
		using: [ 
					(browser text)
						display: [ :one :two | one asString , two asString ];
						allowNil ].
	window := browser openOn: 42.
	((browser paneNamed: #one) port: #selection) value: 2.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText equals: '2nil'.
	((browser paneNamed: #two) port: #selection) value: #c.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText equals: '2c'.
	((browser paneNamed: #one) port: #selection) value: nil.
	detailsMorph := window submorphs last submorphs last submorphs first.
	self assert: detailsMorph getText equals: 'nilc'
]

{ #category : #tests }
GLMUpdateMorphicTest >> testAnnouncerUnregistration [
	| subscription |
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size equals: 4.
	browser entity: #($a $b).
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size equals: 4.
	browser entity: #($d).
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size equals: 4.
	browser entity: #().
	subscription := announcer instVarNamed: 'subscriptions'.
	self assert: (subscription at: TestAnnouncement) size equals: 4.
	browser unregisterFromAllAnnouncements.
	subscription := announcer instVarNamed: 'subscriptions'.
	self deny: (subscription includesKey: TestAnnouncement).
	self assert: (announcer instVarNamed: 'subscriptions') isEmpty
]

{ #category : #tests }
GLMUpdateMorphicTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPane [
	| browser treeMorphThree treeMorphThree2 |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two;
		column: #three.	"; column: #four"
	(browser transmit)
		to: #one;
		andShow: [ :a | a list display: [ :x | 1 to: x ] ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | a list display: [ :x | 1 to: x * 2 ] ].
	(browser transmit)
		to: #three;
		from: #two;
		andShow: [ :a | 
					(a list)
						display: [ :x | 1 to: x * 3 ];
						populate: #focus
							on: $f
							entitled: 'Focus'
							with: [ :list | list selection ] ].	"	browser showOn: #four; from: #three; using: [browser text allowNil]."
	(browser transmit)
		to: #outer -> #focus;
		from: #three -> #focus.
	(browser transmit)
		to: #one -> #selection;
		from: #outer -> #focus;
		transformed: [ :x | x + 1 ].
	(browser transmit)
		to: #two -> #selection;
		from: #outer -> #focus;
		transformed: [ :x | x + 2 ].
	window := browser openOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.
	treeMorphThree := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	((browser paneNamed: #three) port: #selection) value: 2.
	((browser paneNamed: #three) port: #focus) value: 1.
	self assert: ((browser paneNamed: #one) port: #entity) value equals: 5.
	self assert: ((browser paneNamed: #one) port: #selection) value equals: 2.
	self assert: ((browser paneNamed: #two) port: #entity) value equals: 2.
	self assert: ((browser paneNamed: #two) port: #selection) value equals: 3.
	self assert: ((browser paneNamed: #three) port: #entity) value equals: 3.
	self assert: ((browser paneNamed: #three) port: #selection) value isNil.
	treeMorphThree2 := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	self assert: treeMorphThree ~= treeMorphThree2
]

{ #category : #tests }
GLMUpdateMorphicTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPaneWithText [
	| browser treeMorphThree treeMorphThree2 |
	browser := GLMTabulator new.
	browser
		column: #one;
		column: #two;
		column: #three.	"; column: #four"
	(browser transmit)
		to: #one;
		andShow: [ :a | a text display: [ :x | 1 to: x ] ].
	(browser transmit)
		to: #two;
		from: #one;
		andShow: [ :a | a text display: [ :x | 1 to: x * 2 ] ].
	(browser transmit)
		to: #three;
		from: #two;
		andShow: [ :a | 
					(a text)
						display: [ :x | 1 to: x * 3 ];
						populate: #focus
							on: $f
							entitled: 'Focus'
							with: [ :list | list selection ] ].	"	browser showOn: #four; from: #three; using: [browser text allowNil]."
	(browser transmit)
		to: #outer -> #focus;
		from: #three -> #focus.
	(browser transmit)
		to: #one -> #selection;
		from: #outer -> #focus;
		transformed: [ :x | x + 1 ].
	(browser transmit)
		to: #two -> #selection;
		from: #outer -> #focus;
		transformed: [ :x | x + 2 ].
	window := browser openOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.
	treeMorphThree := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	((browser paneNamed: #three) port: #selection) value: 2.
	((browser paneNamed: #three) port: #focus) value: 1.
	self assert: ((browser paneNamed: #one) port: #entity) value equals: 5.
	self assert: ((browser paneNamed: #one) port: #selection) value equals: 2.
	self assert: ((browser paneNamed: #two) port: #entity) value equals: 2.
	self assert: ((browser paneNamed: #two) port: #selection) value equals: 3.
	self assert: ((browser paneNamed: #three) port: #entity) value equals: 3.
	self assert: ((browser paneNamed: #three) port: #selection) value isNil.
	treeMorphThree2 := (window submorphs last submorphs at: 5) submorphs first submorphs first.
	self assert: treeMorphThree ~= treeMorphThree2
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
	self assert: listMorph model roots size equals: 2.
	self assert: treeMorph model roots size equals: 2.
	self assert: tableMorph model roots size equals: 2
]

{ #category : #tests }
GLMUpdateMorphicTest >> testUpdateBrowserTitle [
	browser title: 'something'.
	browser update.
	self assert: window label equals: 'something'
]

{ #category : #tests }
GLMUpdateMorphicTest >> testUpdatePresentationTitle [
	browser panes first presentations first title: 'something'.
	browser panes first presentations first update.
	self assert: listLabelMorph contents equals: 'something'
]
