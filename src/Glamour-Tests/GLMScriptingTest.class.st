Class {
	#name : #GLMScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMScriptingTest >> testComplexFinderBrowser [ 
	 
	| browser | 
	browser _ GLMFinder new. 
	(browser list) 
		title: 'Presentation1'; 
		display: [:each | 1 to: each]. 
	browser 
		fromPrevious: #selection; 
		passivelyFromPrevious: #highlight; 
		using: 
				[(browser list) 
						title: 'Presentation2'; 
						display: [:selection :highlight | 1 to: selection + highlight]]. 
	browser startOn: 42. 
	self assert: browser presentations size = 1. 
	self assert: browser presentations first title = 'Presentation1'. 
	self assert: browser transmissions size = 1. 
	self assert: browser transmissions last origins size = 2. 
	self assert: browser transmissions last presentations size = 1. 
	self 
		assert: 
			browser transmissions last presentations first title = 'Presentation2'. 
	self assert: (browser panes first port: #entity) value = 42. 
	(browser panes first port: #highlight) value: 43. 
	(browser panes first port: #selection) value: 41. 
	self assert: browser panes size = 2. 
	self assert: browser panes last presentations last displayValue size = 84. 
	self assert: browser panes last presentations size = 2
]

{ #category : #tests }
GLMScriptingTest >> testConditionalPresentation [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		showOn: #two; 
		from: #one; 
		using: 
				[browser text when: [:x | x = 42]. 
					browser list when: [:x | x > 42]]. 
	((browser paneNamed: #one) port: #selection) value: 42. 
	self assert: (browser paneNamed: #two) matchingPresentations size = 1. 
	self 
		assert: 
			((browser paneNamed: #two) matchingPresentations first isKindOf: 
					GLMTextPresentation). 
	((browser paneNamed: #one) port: #selection) value: 43. 
	self assert: (browser paneNamed: #two) matchingPresentations size = 1. 
	self 
		assert: 
			((browser paneNamed: #two) matchingPresentations first isKindOf: 
					GLMListPresentation)
]

{ #category : #tests }
GLMScriptingTest >> testEntityInUpdateAction [ 
	 
	| browser inputFromActionBlock | 
	browser _ GLMTableLayoutBrowser new. 
	browser column: #one. 
	browser 
		showOn: #one; 
		using: 
				[browser text 
						update: #foo 
						on: $m 
						with: [:list :input | inputFromActionBlock _ input]]. 
	browser startOn: 42. 
	browser panes first presentations first actions first 
		actOn: browser panes first presentations first. 
	self assert: inputFromActionBlock = 42
]

{ #category : #tests }
GLMScriptingTest >> testNestedBrowser [ 
	 
	| browser innerBrowser | 
	browser _ GLMTableLayoutBrowser new. 
	browser column: #one. 
	innerBrowser _ GLMTableLayoutBrowser new. 
	innerBrowser column: #innerOne. 
	innerBrowser 
		showOn: #innerOne; 
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
GLMScriptingTest >> testNestedBrowserWithExplicitTransmission [ 
	 
	| browser innerBrowser | 
	browser _ GLMTableLayoutBrowser new. 
	browser column: #one. 
	innerBrowser _ GLMTableLayoutBrowser new. 
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
GLMScriptingTest >> testPublishing [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
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
GLMScriptingTest >> testReferences [ 
	 
	| browser pane1 | 
	browser _ GLMExplicitBrowser new. 
	pane1 _ GLMPane new name: #pane1. 
	browser addPane: pane1. 
	self 
		assert: (browser resolveOriginPort: #pane1) == (pane1 port: #selection). 
	self 
		assert: (browser resolveOriginPort: #pane1 -> #foo) == (pane1 port: #foo). 
	self 
		assert: (browser resolveDestinationPort: #pane1) == (pane1 port: #entity). 
	self 
		assert: 
			(browser resolveDestinationPort: #pane1 -> #foo) == (pane1 port: #foo). 
	self assert: ((browser resolveOriginPort: #outer) isKindOf: GLMParentPort). 
	self assert: (browser resolveOriginPort: #outer) presentation == browser. 
	self assert: (browser resolveOriginPort: #outer) name = #selection. 
	self 
		assert: 
			((browser resolveOriginPort: #outer -> #foo) isKindOf: GLMParentPort). 
	self 
		assert: 
			(browser resolveOriginPort: #outer -> #foo) presentation == browser. 
	self assert: (browser resolveOriginPort: #outer -> #foo) name = #foo. 
	self 
		assert: 
			((browser resolveDestinationPort: #outer) isKindOf: GLMParentPort). 
	self 
		assert: (browser resolveDestinationPort: #outer) presentation == browser. 
	self assert: (browser resolveDestinationPort: #outer) name = #entity. 
	self 
		assert: 
			((browser resolveDestinationPort: #outer -> #foo) isKindOf: GLMParentPort). 
	self 
		assert: 
			(browser resolveDestinationPort: #outer -> #foo) presentation == browser. 
	self assert: (browser resolveDestinationPort: #outer -> #foo) name = #foo
]

{ #category : #tests }
GLMScriptingTest >> testScriptingDefaults [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
	browser startOn: 42. 
	self assert: browser panes size = 1. 
	self assert: browser jumpstartTransmissions size = 1. 
	self 
		assert: 
			browser jumpstartTransmissions first destination 
				= (browser panes first port: #entity)
]

{ #category : #tests }
GLMScriptingTest >> testSimpleTransmission [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
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
GLMScriptingTest >> testStartTransmission [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		showOn: #one; 
		using: [browser list]. 
	self assert: browser transmissions isEmpty. 
	self assert: browser jumpstartTransmissions size = 1. 
	self assert: (browser paneNamed: #one) presentations isEmpty. 
	self assert: (browser paneNamed: #two) presentations isEmpty. 
	browser startOn: 15. 
	self assert: (browser paneNamed: #one) presentations size = 1. 
	self assert: (browser paneNamed: #two) presentations isEmpty
]

{ #category : #tests }
GLMScriptingTest >> testStartWithOnlyJumpStart [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
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
	self assert: browser transmissions size = 1. 
	self assert: browser jumpstartTransmissions size = 1. 
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
	browser _ GLMTableLayoutBrowser new. 
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
							one _ x. 
							two _ y]]. 
	self assert: browser jumpstartTransmissions isEmpty. 
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
	browser _ GLMTableLayoutBrowser new. 
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
	self assert: (browser paneNamed: #three) matchingPresentations size = 1. 
	((browser paneNamed: #two) port: #selection) value: 43. 
	self assert: ((browser paneNamed: #three) port: #entity) value first = 42. 
	self assert: ((browser paneNamed: #three) port: #entity) value last = 43. 
	self assert: (browser paneNamed: #three) matchingPresentations size = 1
]

{ #category : #tests }
GLMScriptingTest >> testTwoTransmissionsWithOnlyOneEvent [ 
	 
	| browser | 
	browser _ GLMTableLayoutBrowser new. 
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
	self assert: browser jumpstartTransmissions size = 0. 
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
	browser _ GLMTableLayoutBrowser new. 
	browser 
		column: #one; 
		column: #two. 
	browser 
		showOn: #one; 
		using: 
				[browser list 
						update: #foo 
						on: $m 
						with: [:list :input | 42]]. 
	browser 
		showOn: #two; 
		from: #one -> #foo; 
		using: [browser text]. 
	browser startOn: #(1 2 3). 
	self assert: browser panes first presentations size = 1. 
	self assert: browser panes last presentations isEmpty. 
	browser panes first presentations first actions first 
		actOn: browser panes first presentations first. 
	self assert: browser panes second presentations size = 1. 
	self assert: browser panes second presentations first entity = 42
]
