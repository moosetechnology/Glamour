Class {
	#name : #GLMPortTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMPortTest >> testPanePort [ 
	 
	| port | 
	port := GLMTestPane new port: #port1. 
	self assert: port seenTransmissions isEmpty. 
	port value: 42. 
"	self assert: port seenTransmissions size = 0. 
	self assert: port seenTransmissions first origin value = 42. 
	self assert: port seenTransmissions first origin ~= port. 
	self assert: port seenTransmissions first destination == port. 
	self assert: port value = 42"
]

{ #category : #tests }
GLMPortTest >> testPortEquality [ 
	 
	| presentation port | 
	presentation := GLMPresentation new. 
	port := (GLMPresentationBoundPort new) 
		name: #port; 
		presentation: presentation. 
	self assert: port = (presentation pane port: #port). 
	self assert: (presentation pane port: #port) = port. 
	self assert: port hash = (presentation pane port: #port) hash. 
	self assert: (presentation pane port: #port) hash = port hash
]

{ #category : #tests }
GLMPortTest >> testPresentationBoundPort [ 
	 
	| presentation port | 
	presentation := GLMPresentation new. 
	port := (GLMPresentationBoundPort new) 
		name: #port; 
		presentation: presentation. 
	port value: 42. 
	self assert: (presentation pane port: #port) value = 42. 
	(presentation pane port: #port) value: 43. 
	self assert: port value = 43
]

{ #category : #tests }
GLMPortTest >> testSimplePort [ 
	 
	| port | 
	port := GLMSimplePort new. 
	port name: #foo. 
	port value: 42. 
	self assert: port name = #foo. 
	self assert: port value = 42. 
	self assert: port hasPane not
]
