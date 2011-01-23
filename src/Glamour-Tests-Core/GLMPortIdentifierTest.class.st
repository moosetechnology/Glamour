Class {
	#name : #GLMPortIdentifierTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #tests }
GLMPortIdentifierTest >> testAsOriginIdentifier [
	| id |
	id := GLMPortIdentifier new.
	self assert: (id asGlamourOriginIdentifier = id)
]

{ #category : #tests }
GLMPortIdentifierTest >> testAsTargetIdentifier [
	| id |
	id := GLMPortIdentifier new.
	self assert: (id asGlamourTargetIdentifier = id)
]

{ #category : #tests }
GLMPortIdentifierTest >> testAssociationAsOriginIdentifier [
	self assert: ((#pane->#port) asGlamourOriginIdentifier isKindOf: GLMPortIdentifier).
	self assert: ((#pane->#port) asGlamourOriginIdentifier paneName = #pane).
	self assert: ((#pane->#port) asGlamourOriginIdentifier portName = #port).
]

{ #category : #tests }
GLMPortIdentifierTest >> testAssociationAsTargetIdentifier [
	self assert: ((#pane->#port) asGlamourTargetIdentifier isKindOf: GLMPortIdentifier).
	self assert: ((#pane->#port) asGlamourTargetIdentifier paneName = #pane).
	self assert: ((#pane->#port) asGlamourTargetIdentifier portName = #port).
]

{ #category : #tests }
GLMPortIdentifierTest >> testSymbolAsOriginIdentifier [
	self assert: ((#pane) asGlamourOriginIdentifier isKindOf: GLMPortIdentifier).
	self assert: ((#pane) asGlamourOriginIdentifier paneName = #pane).
	self assert: ((#pane) asGlamourOriginIdentifier portName = #selection).
]

{ #category : #tests }
GLMPortIdentifierTest >> testSymbolAsTargetIdentifier [
	self assert: ((#pane) asGlamourTargetIdentifier isKindOf: GLMPortIdentifier).
	self assert: ((#pane) asGlamourTargetIdentifier paneName = #pane).
	self assert: ((#pane) asGlamourTargetIdentifier portName = #entity).
]
