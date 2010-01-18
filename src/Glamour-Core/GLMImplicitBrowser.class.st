"
A GLMImplicitBrowser is a browser that defines an implicit flow of transmissions.
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

{ #category : #accessing }
GLMImplicitBrowser >> presentations [ 
	 
	^presentations ifNil: [presentations := GLMCompositePresentation new]
]
