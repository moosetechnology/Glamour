Class {
	#name : #GLBoundPort,
	#superclass : #GLPort,
	#category : #'Glamour-Core'
}

{ #category : #comparing }
GLBoundPort >> = anObject [
	"Compare this port with another for equality.

	This is used to compare ParentPorts with PanePorts where the earlier is a proxy for the latter."
	
	^((anObject isKindOf: GLBoundPort) and: [self pane = anObject pane])
		and: [self name = anObject name]
]

{ #category : #testing }
GLBoundPort >> hasPane [
	
	^self pane notNil
]

{ #category : #comparing }
GLBoundPort >> hash [
	"Ports which are equal should return hash.

	Since equality is used only for matching port proxies (ParentPort) with
	their actual port, the hash function is overridden only in ParentPort."
	
	^super hash
]

{ #category : #accessing }
GLBoundPort >> pane [
	
	self subclassResponsibility
]
