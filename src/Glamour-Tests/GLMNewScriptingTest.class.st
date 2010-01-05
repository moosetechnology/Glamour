Class {
	#name : #GLMNewScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

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
	self assert: (transmission isKindOf: GLMBundleTransmission). 
	self assert: transmission origins size = 2.
	self assert: transmission origins first = ((browser paneNamed: #one) port: #port1). 
	self assert: transmission origins last = ((browser paneNamed: #two) port: #port2). 
	self assert: transmission destination = ((browser paneNamed: #three) port: #port3).
	self assert: (transmission presentations isKindOf: GLMCompositePresentation).
	self assert: transmission presentations size = 2
]

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testSimpleTransmission [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two. 
	browser send from: #one -> #port1; to: #two -> #port2.
	self assert: browser transmissions size = 1.
	self assert: browser transmissions first browser == browser.
	self assert: (browser transmissions first isKindOf: GLMSimpleTransmission). 
	self assert: browser transmissions first origin = ((browser paneNamed: #one) port: #port1). 
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
