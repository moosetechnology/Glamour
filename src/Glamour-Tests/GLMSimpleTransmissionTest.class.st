Class {
	#name : #GLMSimpleTransmissionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMSimpleTransmissionTest >> testCopy [
	| transmission port1 port2 newTransmission |
	transmission := GLMTransmission new.
	port1 := GLMSimplePort new.
	port2 := GLMSimplePort new.
	transmission destination: port2.
	transmission addActiveOrigin: port1.
	newTransmission := transmission copy.
	self assert: newTransmission destination == transmission destination.
	self assert: newTransmission origins first == transmission origins first.
]

{ #category : #tests }
GLMSimpleTransmissionTest >> testSimple [ 
	| pane1 pane2 transmission | 
	pane1 := GLMPane named: 'test1'. 
	pane2 := GLMPane named: 'test2'. 
	transmission := (GLMTransmission new) 
		addActiveOrigin: (pane1 port: #output); 
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
GLMSimpleTransmissionTest >> testSimpleStrategy [
	self assert: GLMTransmission new strategyBeforeValue class = GLMTransmissionPreValueStrategy
]

{ #category : #tests }
GLMSimpleTransmissionTest >> testTriggerConditions [ 
	"Tests that the transmission is triggered only when the origin changes." 
	
	| transmission port1 port2 | 
	transmission := GLMTransmission new. 
	port1 := GLMPort new name: #port1. 
	port2 := GLMPort new name: #port2. 
	transmission addActiveOrigin: port1. 
	transmission destination: port2. 
	self assert: (transmission originatesAt: port1). 
	self assert: (transmission originatesAt: port2) not. 
	self assert: (transmission originatesAt: GLMPort new) not
]

{ #category : #tests }
GLMSimpleTransmissionTest >> testTriggerConditionsWithParentPort [ 
	 
	| transmission presentation | 
	transmission := GLMTransmission new. 
	presentation := GLMPresentation new. 
	transmission 
		addActiveOrigin: 
			((GLMPresentationBoundPort new) 
				presentation: presentation; 
				name: #port1; 
				yourself). 
	self 
		assert: 
			(transmission 
				originatesAt: 
					((GLMPresentationBoundPort new) 
						presentation: presentation; 
						name: #port1; 
						yourself)). 
	self assert: (transmission originatesAt: (presentation pane port: #port1))
]
