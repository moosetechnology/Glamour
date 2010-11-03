Class {
	#name : #GLMTransmissionScriptingTest,
	#superclass : #TestCase,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Tests-Core'
}

{ #category : #'as yet unclassified' }
GLMTransmissionScriptingTest >> setUp [
	browser := GLMExplicitBrowser new.
	browser addPane: (GLMPane new name: #one).
	browser addPane: (GLMPane new name: #two).
	browser addPane: (GLMPane new name: #three).

]

{ #category : #'as yet unclassified' }
GLMTransmissionScriptingTest >> testFrom [
	browser transmit from: #one.
	self assert: browser transmissions first origins first pane = browser panes first.
	self assert: browser transmissions first origins first name = GLMPortIdentifier defaultOriginPortName
]

{ #category : #'as yet unclassified' }
GLMTransmissionScriptingTest >> testFromPort [
	browser transmit from: #one port: #port.
	self assert: browser transmissions first origins first pane = browser panes first.
	self assert: browser transmissions first origins first name = #port
]

{ #category : #'as yet unclassified' }
GLMTransmissionScriptingTest >> testTo [
	browser transmit to: #one.
	self assert: browser transmissions first destination pane = browser panes first.
	self assert: browser transmissions first destination name = GLMPortIdentifier defaultTargetPortName
]

{ #category : #'as yet unclassified' }
GLMTransmissionScriptingTest >> testToPort [
	browser transmit to: #one port: #port.
	self assert: browser transmissions first destination pane = browser panes first.
	self assert: browser transmissions first destination name = #port
]
