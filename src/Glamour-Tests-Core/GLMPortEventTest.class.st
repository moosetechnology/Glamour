Class {
	#name : #GLMPortEventTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMPortEventTest >> testCreation [
	| anEvent |
	anEvent := GLMPortEvent 
		on: 1
		previouslyValued: 2.
	self assert: anEvent port = 1.
	self assert: anEvent oldValue = 2.
	self assert: anEvent transmissionContext isEmpty.
]

{ #category : #tests }
GLMPortEventTest >> testCreationWithTransmissionContext [
	| anEvent aContext|
	aContext := OrderedCollection new.
	anEvent := GLMPortEvent 
		on: 1
		previouslyValued: 2
		in: aContext.
	self assert: anEvent port = 1.
	self assert: anEvent oldValue = 2.
	self assert: anEvent transmissionContext = aContext.
]

{ #category : #tests }
GLMPortEventTest >> testInterdependentPanesCycleBreak [
	|browser outerCount oneCount |
	outerCount := 0.
	oneCount := 0.
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser list
			display: [:x | 1 to: x]].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x*2]].
	browser showOn: #three; from: #two; using: [
		browser list
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus with: [:x | outerCount := outerCount + 1].
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | oneCount := oneCount + 1].
	browser startOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.
	((browser paneNamed: #three) port: #selection) value: 12.
	((browser paneNamed: #three) port: #focus) value: 12.
	self assert: oneCount = 1.
	self assert: outerCount = 1.
]

{ #category : #tests }
GLMPortEventTest >> testInterdependentPanesProperPorts [
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two; column: #three.
	browser showOn: #one; using: [
		browser list
			display: [:x | 1 to: x]].
	browser showOn: #two; from: #one; using: [
		browser list
			display: [:x | 1 to: x*2]].
	browser showOn: #three; from: #two; using: [
		browser list
			display: [:x | 1 to: x*3];
			populate: #focus on: $f entitled: 'Focus' with: [:list | list selection] ].
	browser sendTo: #outer->#focus from: #three->#focus.
	browser sendTo: #one->#selection from: #outer->#focus with: [:x | x + 1].
	browser sendTo: #two->#selection from: #outer->#focus with: [:x | x + 2].
	browser startOn: 5.
	((browser paneNamed: #one) port: #selection) value: 3.
	((browser paneNamed: #two) port: #selection) value: 6.
	((browser paneNamed: #three) port: #selection) value: 12.
	((browser paneNamed: #three) port: #focus) value: 12.
	self assert: (browser pane port: #focus) value = 12.
	self assert: ((browser paneNamed: #one) port: #entity) value = 5.
	self assert: ((browser paneNamed: #one) port: #selection) value = 13.
	self assert: ((browser paneNamed: #two) port: #entity) value = 13.
	self assert: ((browser paneNamed: #two) port: #selection) value = 14.
	self assert: ((browser paneNamed: #three) port: #entity) value = 14.
	self assert: ((browser paneNamed: #three) port: #selection) value = nil.
]

{ #category : #tests }
GLMPortEventTest >> testPortName [
	| anEvent |
	anEvent := GLMPortEvent 
		on: ((GLMPort new) name: '1'; yourself)
		previouslyValued: 2.
	self assert: anEvent portName = '1'.

]
