Class {
	#name : #GLMPortReferenceTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Core'
}

{ #category : #testing }
GLMPortReferenceTest >> testOriginTransformedValue [
	| port reference |
	port := GLMSimplePort new value: 41.
	reference := GLMOriginPortReference new port: port; transformation: [:x | x + 1 ].
	self assert: reference value = 42
]

{ #category : #testing }
GLMPortReferenceTest >> testOriginValue [
	| port reference |
	port := GLMSimplePort new value: 42.
	reference := GLMOriginPortReference new port: port.
	self assert: reference value = 42
]
