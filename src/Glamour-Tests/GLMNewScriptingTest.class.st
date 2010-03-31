Class {
	#name : #GLMNewScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testBuildingNestedComposites [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; andShow: [ :a |
		a list.
		a text.
		a composite: [:another | 
			another text.
			another list ] ].
	browser startOn: 42.
	self assert: ((browser paneNamed: #one) presentations isKindOf: GLMCompositePresentation).
	self assert: (browser paneNamed: #one) presentations size = 3.
	self assert: ((browser paneNamed: #one) presentations last isKindOf: GLMCompositePresentation).
	self assert: (browser paneNamed: #one) presentations last size = 2
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testBundleTransmission [
	| browser transmission | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two; column: #three. 
	browser transmit from: #one -> #port1; from: #two -> #port2; to: #three -> #port3; andShow: [ :a |
		a list.
		a table ].
	transmission := browser transmissions first.
	self assert: browser transmissions size = 1.
	self assert: transmission browser == browser.
	self assert: (transmission transmissionStrategy isKindOf: GLMReplacePresentationsStrategy). 
	self assert: transmission origins size = 2.
	self assert: transmission origins first = ((browser paneNamed: #one) port: #port1). 
	self assert: transmission origins last = ((browser paneNamed: #two) port: #port2). 
	self assert: transmission destination = ((browser paneNamed: #three) port: #port3).
	self assert: (transmission transmissionStrategy presentations isKindOf: GLMCompositePresentation).
	self assert: transmission transmissionStrategy presentations size = 2
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testBundleTransmissionWithTransformation [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :a | a text ].
	browser transmit from: #one transformed: [:x | x + 1 ]; to: #two; andShow: [ :a | a text ].
	browser startOn: 1.
	((browser paneNamed: #one) port: #selection) value: 41.
	
	self assert: ((browser paneNamed: #two) port: #entity) value = 42
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testEntity [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; andShow: [ :a | a list ].
	browser startOn: ($a to: $d).
	self assert: ((browser paneNamed: #one) port: #entity) value = ($a to: $d)
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testNestedCompositesPaneReference [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; andShow: [ :a |
		a list.
		a text.
		a composite: [:another | 
			another text.
			another list ] ].
	browser startOn: 42.
	(browser paneNamed: #one) presentations do: [:each |
		self assert: each pane == (browser paneNamed: #one) ].
	(browser paneNamed: #one) presentations last do: [:each |
		self assert: each pane == (browser paneNamed: #one) ]
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testSelectionValidation [
	| browser |
	browser := GLMTabulator new.
	browser 
		column: [:c | c row:  #one; row: #two];
		column: #three.
	browser transmit to: #one; andShow: [:a |
		a list display: [:x | 1 to: x ]].
	browser transmit to: #two; from: #one; andShow: [:a |
		a list beMultiple; display: [:x | 1 to: x ] ].
	browser transmit to: #three; from: #two; andShow: [:a |
		a text ].
	browser startOn: 42.
	
	((browser paneNamed: #one) port: #selection) value: 40.
	self assert: ((browser paneNamed: #two) port: #entity) value = 40.
	((browser paneNamed: #two) port: #selection) value: #(10 30 40).
	self assert: ((browser paneNamed: #two) port: #selection) value = #(10 30 40).
	self assert: ((browser paneNamed: #three) port: #entity) value = #(10 30 40).

	((browser paneNamed: #two) port: #selection) value: #(10 30).
	self assert: ((browser paneNamed: #two) port: #selection) value = #(10 30).
	self assert: ((browser paneNamed: #three) port: #entity) value = #(10 30).

	((browser paneNamed: #one) port: #selection) value: 5.
	self assert: ((browser paneNamed: #two) port: #entity) value = 5.
	((browser paneNamed: #two) port: #selection) value: #(1 3).
	self assert: ((browser paneNamed: #two) port: #selection) value = #(1 3).
	self assert: ((browser paneNamed: #three) port: #entity) value = #(1 3).

]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testSimpleTransmission [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser transmit from: #one -> #port1; fromOutside: #outerPort; to: #two -> #port2.
	browser transmit from: #one -> #port3; toOutside: #anotherOuterPort.
	self assert: browser transmissions size = 2.
	self assert: browser transmissions first browser == browser.
	self assert: (browser transmissions first transmissionStrategy isKindOf: GLMNoStrategy). 
	self assert: browser transmissions first origins first = ((browser paneNamed: #one) port: #port1). 
	self assert: browser transmissions first origins last = (browser pane port: #outerPort). 
	self assert: browser transmissions first destination = ((browser paneNamed: #two) port: #port2).

	self assert: browser transmissions last browser == browser.
	self assert: (browser transmissions last transmissionStrategy isKindOf: GLMNoStrategy).
	self assert: browser transmissions last origins first = ((browser paneNamed: #one) port: #port3).
	self assert: browser transmissions last destination = (browser pane port: #anotherOuterPort).

]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testSimpleTransmissionWithCondition [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser transmit from: #one -> #port1; fromOutside: #entity; to: #two -> #port2; when: [:one :outer | 
		one notNil and: [outer notNil and: [one + outer = 42]]].
	browser startOn: 2.
	self assert: ((browser paneNamed: #two) port: #port2) value isNil.
	((browser paneNamed: #one) port: #port1) value: 39.
	self assert: ((browser paneNamed: #two) port: #port2) value isNil.
	((browser paneNamed: #one) port: #port1) value: 40.
	self assert: ((browser paneNamed: #two) port: #port2) value notNil
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testSimpleTransmissionWithTransformation [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser transmit 
		from: #one -> #port1; 
		fromOutside: #entity; 
		to: #two -> #port2; 
		when: [:one :outer | one notNil and: [outer notNil]];
		transformed: [:one :outer | one + outer].
	browser startOn: 2.
	self assert: ((browser paneNamed: #two) port: #port2) value isNil.
	((browser paneNamed: #one) port: #port1) value: 40.
	self assert: ((browser paneNamed: #two) port: #port2) value = 42
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testStartTabulator [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; andShow: [ :a |
		a list.
		a text ].
	browser startOn: 42.
	self assert: ((browser paneNamed: #one) presentations isKindOf: GLMCompositePresentation).
	self assert: (browser paneNamed: #one) presentations size = 2
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testStatusbar [
	| browser |
	browser := GLMTabulator new.
	browser addStatusbar.
	browser row: #one.
	browser transmit to: #one; andShow: [:a | a list display: #(1 2 3)].
	self assert: (browser transmissions size = 2).
	browser startOn: 42.
]
