Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMExamples class >> allExamples [ 
	^ Pragma allNamed: #glmBrowser:input: in: self
]

{ #category : #accessing }
GLMExamples class >> browser [
	^ GLMExamplesBrowser new browser title: self title.
]

{ #category : #opening }
GLMExamples class >> open [
	^ self browser openOn: self
]

{ #category : #accessing }
GLMExamples class >> title [
	^ 'Examples'
]
