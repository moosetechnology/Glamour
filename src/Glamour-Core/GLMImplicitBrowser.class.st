"
A GLMImplicitBrowser is a browser that defines an implicit flow of transmissions.
"
Class {
	#name : #GLMImplicitBrowser,
	#superclass : #GLMBrowser,
	#instVars : [
		'panes',
		'presentations',
		'scriptTransmission'
	],
	#category : #'Glamour-Core'
}

{ #category : #accessing }
GLMImplicitBrowser >> addPresentation: aPresentation [
	self presentations add: aPresentation
]

{ #category : #accessing }
GLMImplicitBrowser >> panes [ 
	 
	^panes ifNil: [panes := OrderedCollection new]
]

{ #category : #accessing }
GLMImplicitBrowser >> presentations [ 
	 
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]
