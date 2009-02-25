Class {
	#name : #GLMScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMScriptingTest >> testConditionalPresentation [ 
	 
	| browser | 
	browser := GLMTableLayoutBrowser new. 
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
GLMScriptingTest >> testNestedBrowser [ 
	 
	| browser innerBrowser | 
	browser := GLMTableLayoutBrowser new. 
	browser column: #one. 
	innerBrowser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
	browser column: #one. 
	innerBrowser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
	browser column: #classes. 
	browser 
		push: #classes -> #selection 
		as: #selectedClass. 
	browser 
		pull: #highlightedClass 
		to: #classes -> #highlight. 
	self assert: browser pushedPorts size = 1. 
	self 
		assert: 
			browser pushedPorts first innerPort 
				= ((browser paneNamed: #classes) port: #selection). 
	self assert: browser pushedPorts first outerPortName = #selectedClass. 
	self assert: browser pulledPorts size = 1. 
	self 
		assert: 
			browser pulledPorts first innerPort 
				= ((browser paneNamed: #classes) port: #highlight). 
	self assert: browser pulledPorts first outerPortName = #highlightedClass
]

{ #category : #tests }
GLMScriptingTest >> testReferences [ 
	 
	| browser pane1 | 
	browser := GLMExplicitBrowser new. 
	pane1 := GLMPane new name: #pane1. 
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
	browser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
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
	browser := GLMTableLayoutBrowser new. 
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
GLMScriptingTest >> testTwoTransmissionsWithOnlyOneEvent [ 
	 
	| browser | 
	browser := GLMTableLayoutBrowser new. 
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
