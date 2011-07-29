Class {
	#name : #GLMUpdateInterdependentPanesTest,
	#superclass : #GLMMorphicTest,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Tests-Morphic'
}

{ #category : #tests }
GLMUpdateInterdependentPanesTest >> testAllowNil [
	| browser detailsMorph |
	browser := GLMTabulator new.
	browser
		column: [ :c | 
					c
						row: #one;
						row: #two ];
		column: #details.
	browser
		transmit to: #one;
		andShow: [ :a | a tree display: #(1 2 3) ].
	browser
		transmit to: #two;
		andShow: [ :a | a tree display: #(#a #b #c) ].
	browser
		transmit to: #details;
		from: #one;
		from: #two;
		andShow: [ :a | 
					(a text)
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
GLMUpdateInterdependentPanesTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPane [
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
		from: #three port: #focus.
	(browser transmit)
		to: #one -> #selection;
		from: #outer port: #focus;
		transformed: [ :x | x + 1 ].
	(browser transmit)
		to: #two -> #selection;
		from: #outer port: #focus;
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
GLMUpdateInterdependentPanesTest >> testInterdependentPanesShouldUpdateTheFocusTriggerPaneWithText [
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
		from: #three port: #focus.
	(browser transmit)
		to: #one -> #selection;
		from: #outer port: #focus;
		transformed: [ :x | x + 1 ].
	(browser transmit)
		to: #two -> #selection;
		from: #outer port: #focus;
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
