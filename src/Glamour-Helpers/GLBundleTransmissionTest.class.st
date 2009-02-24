Class {
	#name : #GLBundleTransmissionTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests'
}

{ #category : #tests }
GLBundleTransmissionTest >> testPorts [
	"Tests that the origins are set up properly and that their order is retained."
	
	| transmission |
	transmission := GLBundleTransmission new.
	transmission
		addActiveOrigin:
			((GLSimplePort new)
				name: #port1;
				value: 1).
	transmission
		addPassiveOrigin:
			((GLSimplePort new)
				name: #port2;
				value: 2).
	transmission
		addActiveOrigin:
			((GLSimplePort new)
				name: #port3;
				value: 3).
	transmission
		addPassiveOrigin:
			((GLSimplePort new)
				name: #port4;
				value: 4).
	transmission destination: (GLSimplePort new name: #port5).
	self assert: transmission bundleOrigins size = 4.
	transmission bundleOrigins
		do: [:each | self assert: (each isKindOf: GLBundleOrigin)].
	self assert: (transmission bundleOrigins at: 1) port name = #port1.
	self assert: (transmission bundleOrigins at: 2) port name = #port2.
	self assert: (transmission bundleOrigins at: 3) port name = #port3.
	self assert: (transmission bundleOrigins at: 4) port name = #port4.
	self assert: transmission origins size = 4.
	transmission origins
		do: [:each | self assert: (each isKindOf: GLSimplePort)].
	self assert: (transmission origins at: 1) name = #port1.
	self assert: (transmission origins at: 2) name = #port2.
	self assert: (transmission origins at: 3) name = #port3.
	self assert: (transmission origins at: 4) name = #port4.
	self assert: transmission activeOrigins size = 2.
	transmission activeOrigins
		do: [:each | self assert: (each isKindOf: GLSimplePort)].
	self assert: (transmission activeOrigins at: 1) name = #port1.
	self assert: (transmission activeOrigins at: 2) name = #port3.
	self assert: transmission passiveOrigins size = 2.
	transmission passiveOrigins
		do: [:each | self assert: (each isKindOf: GLSimplePort)].
	self assert: (transmission passiveOrigins at: 1) name = #port2.
	self assert: (transmission passiveOrigins at: 2) name = #port4.
	self assert: (transmission destination isKindOf: GLSimplePort).
	self assert: transmission destination name = #port5
]

{ #category : #tests }
GLBundleTransmissionTest >> testPresentations [
	"Tests that the presentations are set up correctly."
	
	| transmission presentation1 presentation2 presentation3 |
	transmission := GLBundleTransmission new.
	transmission
		addActiveOrigin:
			((GLSimplePort new)
				name: #port1;
				value: 1).
	transmission
		addPassiveOrigin:
			((GLSimplePort new)
				name: #port2;
				value: 2).
	transmission destination: (GLSimplePort new name: #port3).
	presentation1 := GLPresentation new title: 'presentation1'.
	presentation2 := GLPresentation new title: 'presentation2'.
	presentation3 := GLPresentation new title: 'presentation3'.
	transmission addPresentation: presentation1.
	transmission addPresentation: presentation2.
	transmission addPresentation: presentation3.	"Test correct setup"
	self assert: transmission presentations size = 3.
	self assert: (transmission presentations at: 1) == presentation1.
	self assert: (transmission presentations at: 2) == presentation2.
	self assert: (transmission presentations at: 3) == presentation3
]

{ #category : #tests }
GLBundleTransmissionTest >> testTransmitting [
	"Tests that the origins are set up properly and that their order is retained."
	
	| transmission |
	transmission := GLBundleTransmission new.
	transmission
		addActiveOrigin:
			((GLSimplePort new)
				name: #port1;
				value: 1).
	transmission destination: (GLSimplePort new name: #port5).
	self assert: transmission value = 1.
	self assert: transmission destination value isNil.
	transmission transmit.
	self assert: transmission destination value = 1.
	transmission
		addPassiveOrigin:
			((GLSimplePort new)
				name: #port2;
				value: 2).
	transmission
		addActiveOrigin:
			((GLSimplePort new)
				name: #port3;
				value: 3).
	transmission
		addPassiveOrigin:
			((GLSimplePort new)
				name: #port4;
				value: 4).
	self assert: transmission value = (GLMultiValue withAll: #(1 2 3 4)).
	transmission transmit.
	self
		assert:
			transmission destination value = (GLMultiValue withAll: #(1 2 3 4))
]

{ #category : #tests }
GLBundleTransmissionTest >> testTriggerConditions [
	"Tests that the transmission is triggered only when the active origins change."
	
	| transmission port1 port2 |
	transmission := GLBundleTransmission new.
	port1 := GLPort new name: #port1.
	port2 := GLPort new name: #port2.
	transmission addActiveOrigin: port1.
	transmission addPassiveOrigin: port2.
	transmission destination: (GLPort new name: #port3).
	self assert: (transmission originatesAt: port1).
	self assert: (transmission originatesAt: port2) not
]

{ #category : #tests }
GLBundleTransmissionTest >> testTriggerConditionsWithParentPort [
	
	| transmission presentation |
	transmission := GLBundleTransmission new.
	presentation := GLPresentation new.
	transmission
		addActiveOrigin:
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
