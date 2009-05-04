Class {
	#name : #GLMSimpleTransmissionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLMSimpleTransmissionTest >> testSimple [ 
	 
	| pane1 pane2 transmission | 
	pane1 _ GLMPane new. 
	pane2 _ GLMPane new. 
	transmission _ (GLMSimpleTransmission new) 
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
GLMSimpleTransmissionTest >> testTriggerConditions [ 
	"Tests that the transmission is triggered only when the origin changes." 
	 
	| transmission port1 port2 | 
	transmission _ GLMSimpleTransmission new. 
	port1 _ GLMPort new name: #port1. 
	port2 _ GLMPort new name: #port2. 
	transmission origin: port1. 
	transmission destination: port2. 
	self assert: (transmission originatesAt: port1). 
	self assert: (transmission originatesAt: port2) not. 
	self assert: (transmission originatesAt: GLMPort new) not
]

{ #category : #tests }
GLMSimpleTransmissionTest >> testTriggerConditionsWithParentPort [ 
	 
	| transmission presentation | 
	transmission _ GLMSimpleTransmission new. 
	presentation _ GLMPresentation new. 
	transmission 
		origin: 
			((GLMParentPort new) 
				presentation: presentation; 
				name: #port1; 
				yourself). 
	self 
		assert: 
			(transmission 
				originatesAt: 
					((GLMParentPort new) 
						presentation: presentation; 
						name: #port1; 
						yourself)). 
	self assert: (transmission originatesAt: (presentation pane port: #port1))
]
