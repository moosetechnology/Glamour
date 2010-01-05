Class {
	#name : #GLMNewScriptingTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #'as yet unclassified' }
GLMNewScriptingTest >> testBundleTransmission [
	| browser | 
	browser := GLMTabulator new. 
	browser column: #one; column: #two; column: #three. 
	browser transmit from: #one -> #port1; from: #two -> #port2; to: #three -> #port3; showing: [ :a |
		a list ].
	self assert: browser transmissions size = 1.
	self assert: browser transmissions first browser == browser.
	self assert: (browser transmissions first isKindOf: GLMBundleTransmission). 
	self assert: browser transmissions first origins size = 2.
	self assert: browser transmissions first origins first = 
		((browser paneNamed: #one) port: #port1). 
	self assert: browser transmissions first origins last = 
		((browser paneNamed: #two) port: #port2). 
	self assert: browser transmissions first destination = ((browser paneNamed: #three) port: #port3).

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
