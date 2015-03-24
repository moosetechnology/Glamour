Class {
	#name : #GLMPoppupAction,
	#superclass : #GLMAction,
	#category : #'Glamour-Core'
}

{ #category : #actions }
GLMPoppupAction >> poppupActOn: x from: y [

	self halt.
]

{ #category : #rendering }
GLMPoppupAction >> renderGlamorouslyOn: aRenderer [
	^aRenderer renderPoppupAction: self
]
