Class {
	#name : #GLMPortTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMPortTest >> testPanePortTransmissionCallingReceiveIn [
	| originPort destinationPort transmission | 
	originPort := GLMTestPane new port: #originPort. 
	destinationPort := GLMTestPane new port: #destinationPort. 
	self assert: destinationPort seenTransmissions isEmpty. 
	transmission := GLMTransmission new 
		addActiveOrigin: originPort; 
		destination: destinationPort; 
		transformation: [:x | x + 1].
	originPort value: 41.
	transmission transmit.
	self assert: destinationPort seenTransmissions size = 1.
	self assert: destinationPort seenTransmissions first origins first value = 41. 
	self assert: destinationPort seenTransmissions first destination == destinationPort. 
	self assert: destinationPort value = 42
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
GLMPortTest >> testResetValue [
	 
	| port | 
	port := GLMTestPane new port: #port1. 
	port value: 42.
	self assert: port value = 42.
	port resetValue.
	self assert: port value isNil
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

{ #category : #tests }
GLMPortTest >> testTransientValue [
	 
	| port pane browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit fromOutsidePort: #entity; to: #one port: #entity.
	browser transmit from: #one port: #entity; to: #two; andShow: [:a | a text ].
	browser startOn: 42.
	self assert: (browser panes first port: #entity) value = 42.
	self assert: (browser panes last port: #entity) value = 42.
	
	(browser panes first port: #entity) transientValue: 43.
	self assert: (browser pane port: #entity) value = 42.
	self assert: (browser panes first port: #entity) value = 42.
	self assert: (browser panes last port: #entity) value = 43.

	(browser pane port: #entity) transientValue: 44.
	self assert: (browser pane port: #entity) value = 42.
	self assert: (browser panes first port: #entity) value = 44.
	self assert: (browser panes last port: #entity) value = 44
]
