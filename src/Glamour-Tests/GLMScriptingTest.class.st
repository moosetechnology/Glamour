Class {
	#name : #GLMScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #testing }
GLMScriptingTest >> expectedFailures [
	^ #(#testComposite #testPublishingToOutsideFinder)
]

{ #category : #tests }
GLMScriptingTest >> testActionDefinition [ 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser showOn: #one; using: [
		browser text act: [] entitled: ''.
		browser list act: [] entitled: ''.
		browser tree act: [] entitled: '']. 
	browser startOn: #(42).
	browser panes first presentations do: [:each | 
		self assert: each actions size = 1]
]

{ #category : #tests }
GLMScriptingTest >> testAllowNil [
	| browser presentationsChanged matchingPresentationsChanged |
	browser := GLMTabulator new.
	browser 
		column: [: c | c row: #one; row: #two];
		column: #details.
	browser showOn: #one; using: [
		browser tree display: #(1 2 3)].
	browser showOn: #two; using: [
		browser tree display: #(a b c)].
	browser showOn: #details; from: #one; from: #two; using: [
		browser text 
			display: [ :one :two | one asString, two asString];
			allowNil ].
	browser startOn: 42.
	(browser paneNamed: #details) whenPresentationsChanged: [:a | presentationsChanged := true ].
	(browser paneNamed: #details) whenMatchingPresentationsChanged: [:a | matchingPresentationsChanged := true ].
	presentationsChanged := false.
	matchingPresentationsChanged := false.

	((browser paneNamed: #one) port: #selection) value: 2.
	self assert: presentationsChanged.
	self assert: matchingPresentationsChanged.
	self assert: ((browser paneNamed: #details) presentations first) displayValue = '2nil'.
	presentationsChanged := false.

	((browser paneNamed: #two) port: #selection) value: #c.
	self assert: presentationsChanged.
	self assert: matchingPresentationsChanged.
	self assert: ((browser paneNamed: #details) presentations first) displayValue = '2c'.
	presentationsChanged := false.

	((browser paneNamed: #one) port: #selection) value: nil.
	self assert: presentationsChanged.
	self assert: matchingPresentationsChanged.
	self assert: ((browser paneNamed: #details) presentations first) displayValue = 'nilc'.
]

{ #category : #tests }
GLMScriptingTest >> testComplexFinderBrowser [ 
	 
	| browser | 
	browser := GLMFinder new. 
	browser list
		title: 'Presentation1'; 
		display: [:each | 1 to: each]. 
	browser 
		fromPrevious: #selection; 
		passivelyFromPrevious: #highlight; 
		using: [
			browser list
				title: 'Presentation2'; 
				display: [:selection :highlight | 1 to: selection + highlight]]. 
	browser startOn: 42. 
	self assert: browser presentations size = 1. 
	self assert: browser presentations first title = 'Presentation1'. 
	self assert: browser transmissions size = 1. 
	self assert: browser transmissions last origins size = 2. 
	self assert: browser transmissions last presentations size = 1. 
	self assert: browser transmissions last presentations first title = 'Presentation2'. 
	self assert: (browser panes first port: #entity) value = 42. 
	(browser panes first port: #highlight) value: 43. 
	(browser panes first port: #selection) value: 41. 
	self assert: browser panes size = 2. 
	self assert: browser panes last presentations last displayValue size = 84. 
	self assert: browser panes last presentations size = 2
]

{ #category : #tests }
GLMScriptingTest >> testComposite [
	 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser showOn: #one; using: [
		browser composite with: [
			browser list.
			browser text]].
	browser startOn: 42. 
	self assert: (browser paneNamed: #one) presentations size = 1. 
	self assert: (browser paneNamed: #one) presentations first presentations size = 2.
]

{ #category : #tests }
GLMScriptingTest >> testConditionalPresentation [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser showOn: #two; from: #one; using: [
		browser text when: [:x | x = 42]. 
		browser list when: [:x | x > 42]]. 
	((browser paneNamed: #one) port: #selection) value: 42. 
	self assert: (browser paneNamed: #two) matchingPresentations size = 1. 
	self assert: ((browser paneNamed: #two) matchingPresentations first isKindOf: 
					GLMTextPresentation). 
	((browser paneNamed: #one) port: #selection) value: 43. 
	self assert: (browser paneNamed: #two) matchingPresentations size = 1. 
	self assert: ((browser paneNamed: #two) matchingPresentations first isKindOf: 
					GLMListPresentation)
]

{ #category : #tests }
GLMScriptingTest >> testDynamicActions [
	| browser |
	browser := GLMTabulator new.
	browser column: #one.
	browser
		showOn: #one;
		using: [ browser list
				display: [ :x | 1 to: x ];
				actions: [ :list | 
					(1 to: list selection) collect: 
						[ :index | 
						GLMAction new
							action: [ index ];
							title: 'Action' , index printString;
							yourself ] ] ].
	browser startOn: 42.
	(browser panes first port: #selection) value: 3.
	self assert: browser panes first presentations first dynamicActions size = 3.
	(browser panes first port: #selection) value: 5.
	self assert: browser panes first presentations first dynamicActions size = 5
]

{ #category : #tests }
GLMScriptingTest >> testEntityInUpdateAction [ 
	 
	| browser inputFromActionBlock | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser 
		showOn: #one; 
		using: 
				[browser text 
						update: #foo 
						on: $m 
						with: [:list :input | inputFromActionBlock := input]]. 
	browser startOn: 42. 
	browser panes first presentations first actions first 
		actOn: browser panes first presentations first. 
	self assert: inputFromActionBlock = 42
]

{ #category : #tests }
GLMScriptingTest >> testNestedBrowserEntity [
	 
	| browser innerBrowser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	innerBrowser := GLMTabulator new. 
	innerBrowser column: #innerOne. 
	innerBrowser 
		showOn: #innerOne;
		from: #outer->#entity;
		using: [innerBrowser text]. 
	browser 
		showOn: #one; 
		using: [
			(browser custom: innerBrowser)
				display: [:x | x + 2 ]]. 
	browser startOn: 40. 
	self assert: ((browser paneNamed: #one) port: #entity) value = 40. 
	self assert: (innerBrowser pane port: #entity) value = 40.
	self assert: ((innerBrowser paneNamed: #innerOne) port: #entity) value = 42.
]

{ #category : #tests }
GLMScriptingTest >> testNestedBrowserOther [
	 
	| browser innerBrowser | 
	browser := GLMTabulator new.
	browser column: #one; column: #two. 
	innerBrowser := GLMTabulator new. 
	innerBrowser column: #innerOne. 
	innerBrowser 
		showOn: #innerOne;
"		from: #outer->#entity;"
		using: [innerBrowser text].
	innerBrowser sendToOutside: #selection from: #innerOne.
	browser showOn: #one; using: [
		(browser custom: innerBrowser)
			display: [:x | x + 2 ]]. 
	browser showOn: #two; from: #one; using: [browser text].
	browser startOn: 40. 
	self assert: ((browser paneNamed: #one) port: #entity) value = 40. 
	self assert: (innerBrowser pane port: #entity) value = 40.
	self assert: ((innerBrowser paneNamed: #innerOne) port: #entity) value = 42.
	(innerBrowser panes first port: #selection) value: 7.
	self assert: (innerBrowser pane port: #selection) value = 7.
	self assert: (browser panes last port: #entity) value = 7.
]

{ #category : #tests }
GLMScriptingTest >> testNestedBrowserWithExplicitTransmission [ 
	 
	| browser innerBrowser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	innerBrowser := GLMTabulator new. 
	innerBrowser column: #innerOne. 
	innerBrowser 
		showOn: #innerOne; 
		from: #outer -> #entity; 
		using: [innerBrowser text]. 
	browser 
		showOn: #one; 
		using: [browser custom: innerBrowser]. 
	browser startOn: 42. 
	self assert: ((browser paneNamed: #one) port: #entity) value = 42. 
	self 
		assert: ((innerBrowser paneNamed: #innerOne) port: #entity) value = 42
]

{ #category : #tests }
GLMScriptingTest >> testOuterEntity [ 
	| browser innerBrowser | 
	browser := GLMTabulator new.
	browser column: #one; column: #two. 
	browser showOn: #one; using: [browser text]. 
	browser showOn: #two; fromOutside: #entity; using: [browser text].
	browser startOn: 42.
	self assert: browser transmissions first origins anyOne name = #entity.
	self assert: browser transmissions last origins anyOne name = #entity.
	self assert: browser transmissions size = 2.
	
]

{ #category : #tests }
GLMScriptingTest >> testPublishing [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #classes. 
	browser 
		sendToOutside: #selectedClass 
		from: #classes -> #selection. 
	browser 
		sendTo: #classes -> #highlight 
		fromOutside: #highlightedClass. 
	(browser panes first port: #selection) value: 42. 
	self assert: (browser pane port: #selectedClass) value = 42. 
	self assert: (browser panes first port: #selection) value = 42. 
	(browser pane port: #highlightedClass) value: 43. 
	self assert: (browser pane port: #highlightedClass) value = 43. 
	self assert: (browser panes first port: #highlight) value = 43. 
	(browser panes first port: #highlight) value: 44. 
	self assert: (browser pane port: #highlightedClass) value = 43. 
	self assert: (browser panes first port: #highlight) value = 44. 
	(browser pane port: #selectedClass) value: 45. 
	self assert: (browser pane port: #selectedClass) value = 45. 
	self assert: (browser panes first port: #selection) value = 42
]

{ #category : #tests }
GLMScriptingTest >> testPublishingToOutsideFinder [
	| innerBrowser finder | 
	finder := GLMFinder new.
	innerBrowser := GLMTabulator new.
	innerBrowser column: #any.
	innerBrowser showOn: #any; using: [ innerBrowser list display: [:x | 1 to: 43 ] ].
	innerBrowser
		sendToOutside: #selection
		from: #any -> #selection.
	finder custom: innerBrowser.
	finder startOn: 43.
	self assert: (finder panes first port: #entity) value = 43.
	self assert: (finder panes first port: #selection) value isNil.
	((finder panes first presentations first paneNamed: #any) port: #selection) value: 42.
	self assert: (finder panes first port: #selection) value = 42.
	self assert: (finder panes first port: #entity) value = 43.
	self assert: finder panes size = 2.
	self assert: (finder panes last port: #entity) value = 42.
	
	self assert: (finder panes first presentations first isKindOf: GLMTabulator).
	self assert: (finder panes last presentations first isKindOf: GLMTabulator).
	self assert: (finder panes first presentations first isKindOf: GLMTabulator).
	
]

{ #category : #tests }
GLMScriptingTest >> testReferences [
	| browser pane1 | 
	browser := GLMExplicitBrowser new.  
 	pane1 := browser addNewPaneNamed: #pane1.
	self assert: (browser resolveOriginPort: #pane1) == (pane1 port: #selection). 
	self assert: (browser resolveOriginPort: #pane1 -> #foo) == (pane1 port: #foo). 
	self assert: (browser resolveDestinationPort: #pane1) == (pane1 port: #entity). 
	self assert: (browser resolveDestinationPort: #pane1 -> #foo) == (pane1 port: #foo). 
	self assert: ((browser resolveOriginPort: #outer) isKindOf: GLMParentPort). 
	self assert: (browser resolveOriginPort: #outer) presentation == browser. 
	self assert: (browser resolveOriginPort: #outer) name = #selection. 
	self assert: ((browser resolveOriginPort: #outer -> #foo) isKindOf: GLMParentPort). 
	self assert: (browser resolveOriginPort: #outer -> #foo) presentation == browser. 
	self assert: (browser resolveOriginPort: #outer -> #foo) name = #foo. 
	self assert: ((browser resolveDestinationPort: #outer) isKindOf: GLMParentPort). 
	self assert: (browser resolveDestinationPort: #outer) presentation == browser. 
	self assert: (browser resolveDestinationPort: #outer) name = #entity. 
	self assert: ((browser resolveDestinationPort: #outer -> #foo) isKindOf: GLMParentPort). 
	self assert: (browser resolveDestinationPort: #outer -> #foo) presentation == browser. 
	self assert: (browser resolveDestinationPort: #outer -> #foo) name = #foo
]

{ #category : #tests }
GLMScriptingTest >> testScriptingDefaults [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser startOn: 42. 
	self assert: browser panes size = 1. 
	self assert: browser transmissions size = 1.
	self assert: browser transmissions first origins first
				= (browser pane port: #entity).
	self assert: browser transmissions first destination 
				= (browser panes first port: #entity)
]

{ #category : #tests }
GLMScriptingTest >> testSimpleTransmission [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		sendTo: #two -> #port2 
		from: #one -> #port1. 
	self assert: browser transmissions size = 1. 
	self assert: (browser transmissions first isKindOf: GLMSimpleTransmission). 
	self 
		assert: 
			browser transmissions first origin 
				= ((browser paneNamed: #one) port: #port1). 
	self 
		assert: 
			browser transmissions first destination 
				= ((browser paneNamed: #two) port: #port2)
]

{ #category : #tests }
GLMScriptingTest >> testSimpleTransmissionsToOuter [
	 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser sendTo: #outer->#increased from: #outer->#entity with: [ :x | x + 1 ].
	browser showOn: #one; from: #outer->#increased; using: [browser text].
	browser startOn: 41.
	self assert: ((browser paneNamed: #one) port: #entity) value = 42

]

{ #category : #tests }
GLMScriptingTest >> testStartTransmission [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		showOn: #one; 
		using: [browser list]. 
	self assert: browser transmissions size = 1.
	self assert: (browser paneNamed: #one) presentations isEmpty. 
	self assert: (browser paneNamed: #two) presentations isEmpty. 
	browser startOn: 15. 
	self assert: (browser paneNamed: #one) presentations size = 1. 
	self assert: (browser paneNamed: #two) presentations isEmpty
]

{ #category : #tests }
GLMScriptingTest >> testStartWithOnlyJumpStart [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		showOn: #one; 
		using: [browser list]. 
	browser 
		showOn: #two; 
		from: #one; 
		using: [browser text]. 
	self assert: browser transmissions size = 2.
	self assert: (browser paneNamed: #one) presentations isEmpty. 
	self assert: (browser paneNamed: #two) presentations isEmpty. 
	browser startOn: #(15 25 35). 
	self assert: (browser paneNamed: #one) presentations size = 1. 
	self assert: (browser paneNamed: #one) matchingPresentations size = 1. 
	self assert: (browser paneNamed: #two) presentations isEmpty. 
	self assert: (browser paneNamed: #two) matchingPresentations isEmpty
]

{ #category : #tests }
GLMScriptingTest >> testThreePanesTransmissions [ 
	 
	| browser one two | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two; 
		column: #three. 
	browser 
		showOn: #three; 
		from: #one; 
		passivelyFrom: #two; 
		using: 
				[browser text 
						display: 
							[:x :y |  
							one := x. 
							two := y]]. 
	self assert: browser transmissions size = 1. 
	self assert: browser transmissions first passiveOrigins size = 1. 
	self assert: browser transmissions first activeOrigins size = 1. 
	((browser paneNamed: #two) port: #selection) value: 15. 
	self assert: ((browser paneNamed: #two) port: #selection) value = 15. 
	self assert: ((browser paneNamed: #three) port: #entity) value isNil. 
	((browser paneNamed: #one) port: #selection) value: 20. 
	self assert: ((browser paneNamed: #one) port: #selection) value = 20. 
	self assert: ((browser paneNamed: #three) port: #entity) value first = 20. 
	self assert: ((browser paneNamed: #three) port: #entity) value last = 15
]

{ #category : #tests }
GLMScriptingTest >> testTransmissionWithTwoOrigins [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two; 
		column: #three. 
	browser 
		showOn: #three; 
		from: #one; 
		from: #two; 
		using: [browser text]. 
	((browser paneNamed: #one) port: #selection) value: 42. 
	self assert: ((browser paneNamed: #three) port: #entity) value first = 42. 
	self assert: ((browser paneNamed: #three) port: #entity) value last = nil. 
	self assert: (browser paneNamed: #three) presentations size = 1. 
	self assert: (browser paneNamed: #three) matchingPresentations size = 0. 
	((browser paneNamed: #two) port: #selection) value: 43. 
	self assert: ((browser paneNamed: #three) port: #entity) value first = 42. 
	self assert: ((browser paneNamed: #three) port: #entity) value last = 43. 
	self assert: (browser paneNamed: #three) matchingPresentations size = 1
]

{ #category : #tests }
GLMScriptingTest >> testTwoTransmissionsWithOnlyOneEvent [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser 
		column: #one; 
		column: #two; 
		column: #three. 
	browser 
		showOn: #two; 
		from: #one; 
		using: [browser list]. 
	browser 
		showOn: #three; 
		from: #two; 
		using: [browser text]. 
	self assert: browser transmissions size = 2. 
	self assert: (browser paneNamed: #one) presentations isEmpty. 
	self assert: (browser paneNamed: #two) presentations isEmpty. 
	self assert: (browser paneNamed: #three) presentations isEmpty. 
	((browser paneNamed: #one) port: #selection) value: 42. 
	self assert: ((browser paneNamed: #two) port: #entity) value = 42. 
	self assert: (browser paneNamed: #one) presentations isEmpty. 
	self assert: (browser paneNamed: #two) presentations size = 1. 
	self assert: (browser paneNamed: #two) matchingPresentations size = 1. 
	self assert: (browser paneNamed: #three) presentations isEmpty. 
	self assert: (browser paneNamed: #three) matchingPresentations isEmpty
]

{ #category : #tests }
GLMScriptingTest >> testUpdateAction [ 
	 
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser showOn: #one; using: [
		browser list update: #foo on: $m with: [:list :input | 42]]. 
	browser showOn: #two; from: #one -> #foo; using: [browser text]. 
	browser startOn: #(1 2 3). 
	self assert: browser panes first presentations size = 1. 
	self assert: browser panes last presentations isEmpty. 
	browser panes first presentations first actions first 
		actOn: browser panes first presentations first. 
	self assert: browser panes second presentations size = 1. 
	self assert: browser panes second presentations first entity = 42
]

{ #category : #tests }
GLMScriptingTest >> testUpdateYourselfOn [

	| announcer entity browser presentation |
	announcer := Announcer new.
	entity := OrderedCollection with: 1 with: 2 with: 3.
	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		presentation := browser list 
			updateYourselfOn: TestAnnouncement from: [ announcer ];
			shouldValidate: true ].
	browser startOn: entity.
	presentation registerAnnouncements.
	presentation selection: 3.
	entity removeLast.
	announcer announce: TestAnnouncement.
	self assert: presentation selection isNil 
]
