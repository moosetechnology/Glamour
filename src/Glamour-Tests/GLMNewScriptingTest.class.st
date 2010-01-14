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
	browser transmit to: #one; showing: [ :a |
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
	browser transmit from: #one -> #port1; from: #two -> #port2; to: #three -> #port3; showing: [ :a |
		a list.
		a table ].
	transmission := browser transmissions first.
	self assert: browser transmissions size = 1.
	self assert: transmission browser == browser.
	self assert: (transmission transmissionStrategy isKindOf: GLMTransmissionBundleStrategy). 
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
	browser transmit to: #one; showing: [ :a | a text ].
	browser transmit from: #one transformed: [:x | x + 1 ]; to: #two; showing: [ :a | a text ].
	browser startOn: 1.
	((browser paneNamed: #one) port: #selection) value: 41.
	
	self assert: ((browser paneNamed: #two) port: #entity) value = 42
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testNestedCompositesPaneReference [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; showing: [ :a |
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
	browser transmit to: #one; showing: [:a |
		a list display: [:x | 1 to: x ]].
	browser transmit to: #two; from: #one; showing: [:a |
		a list beMultiple; display: [:x | 1 to: x ] ].
	browser transmit to: #three; from: #two; showing: [:a |
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
	browser send from: #one -> #port1; to: #two -> #port2.
	self assert: browser transmissions size = 1.
	self assert: browser transmissions first browser == browser.
	self assert: (browser transmissions first transmissionStrategy isKindOf: GLMTransmissionPreValueStrategy). 
	self assert: browser transmissions first origins first = ((browser paneNamed: #one) port: #port1). 
	self assert: browser transmissions first destination = ((browser paneNamed: #two) port: #port2).

]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testStartTabulator [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one. 
	browser transmit to: #one; showing: [ :a |
		a list.
		a text ].
	browser startOn: 42.
	self assert: ((browser paneNamed: #one) presentations isKindOf: GLMCompositePresentation).
	self assert: (browser paneNamed: #one) presentations size = 2
]
