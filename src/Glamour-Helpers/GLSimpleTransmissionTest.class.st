Class {
	#name : #GLSimpleTransmissionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLSimpleTransmissionTest >> testSimple [
	
	| pane1 pane2 transmission |
	pane1 := GLPane new.
	pane2 := GLPane new.
	transmission := (GLSimpleTransmission new)
		origin: (pane1 port: #output);
		destination: (pane2 port: #input);
		yourself.
	(pane1 port: #output) value: 42.
	self assert: (pane1 port: #output) value = 42.
	self assert: (pane2 port: #input) value = nil.
	transmission transmit.
	self assert: (pane1 port: #output) value = 42.
	self assert: (pane2 port: #input) value = 42
]

{ #category : #tests }
GLSimpleTransmissionTest >> testTriggerConditions [
	"Tests that the transmission is triggered only when the origin changes."
	
	| transmission port1 port2 |
	transmission := GLSimpleTransmission new.
	port1 := GLPort new name: #port1.
	port2 := GLPort new name: #port2.
	transmission origin: port1.
	transmission destination: port2.
	self assert: (transmission originatesAt: port1).
	self assert: (transmission originatesAt: port2) not.
	self assert: (transmission originatesAt: GLPort new) not
]

{ #category : #tests }
GLSimpleTransmissionTest >> testTriggerConditionsWithParentPort [
	
	| transmission presentation |
	transmission := GLSimpleTransmission new.
	presentation := GLPresentation new.
	transmission
		origin:
			((GLParentPort new)
				presentation: presentation;
				name: #port1;
				yourself).
	self
		assert:
			(transmission
				originatesAt:
					((GLParentPort new)
						presentation: presentation;
						name: #port1;
						yourself)).
	self assert: (transmission originatesAt: (presentation pane port: #port1))
]
