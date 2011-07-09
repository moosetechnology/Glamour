"
A GLMImplicitBrowser is an abstract implementation of a browser that defines an implicit flow of transmissions.

When using implicit browsers, the developer does not have access to the internal transmissions.
"
Class {
	#name : #GLMImplicitBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'presentations',
		'scriptTransmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMImplicitBrowser >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #scripting }
GLMImplicitBrowser >> custom: aPresentation [ 
	 
	scriptTransmission isNil 
		ifTrue: [self addPresentation: aPresentation] 
		ifFalse: [self scriptTransmission addPresentation: aPresentation]. 
	^aPresentation
]

{ #category : #accessing }
GLMImplicitBrowser >> presentations [ 
	 
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]

{ #category : #accessing }
GLMImplicitBrowser >> scriptTransmission [
	^ scriptTransmission 
		ifNil: [scriptTransmission := GLMTransmission new ensureReplacePresentationsStrategy]
]

{ #category : #scripting }
GLMImplicitBrowser >> show: aBlock [
	^ aBlock value: self presentations
]
