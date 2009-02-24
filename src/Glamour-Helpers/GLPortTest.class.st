Class {
	#name : #GLPortTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLPortTest >> testPanePort [
	
	| port |
	port := GLTestPane new port: #port1.
	self assert: port seenTransmissions isEmpty.
	port value: 42.
	self assert: port seenTransmissions size = 1.
	self assert: port seenTransmissions first origin value = 42.
	self assert: port seenTransmissions first origin ~= port.
	self assert: port seenTransmissions first destination == port.
	self assert: port value = 42
]

{ #category : #tests }
GLPortTest >> testParentPort [
	
	| presentation port |
	presentation := GLPresentation new.
	port := (GLParentPort new)
		name: #port;
		presentation: presentation.
	port value: 42.
	self assert: (presentation pane port: #port) value = 42.
	(presentation pane port: #port) value: 43.
	self assert: port value = 43
]

{ #category : #tests }
GLPortTest >> testPortEquality [
	
	| presentation port |
	presentation := GLPresentation new.
	port := (GLParentPort new)
		name: #port;
		presentation: presentation.
	self assert: port = (presentation pane port: #port).
	self assert: (presentation pane port: #port) = port.
	self assert: port hash = (presentation pane port: #port) hash.
	self assert: (presentation pane port: #port) hash = port hash
]

{ #category : #tests }
GLPortTest >> testSimplePort [
	
	| port |
	port := GLSimplePort new.
	port name: #foo.
	port value: 42.
	self assert: port name = #foo.
	self assert: port value = 42.
	self assert: port hasPane not
]
