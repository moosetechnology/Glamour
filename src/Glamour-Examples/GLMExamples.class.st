Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMExamples class >> allExamples [ 
	^ Pragma allNamed: #glmBrowser:input: in: self
]

{ #category : #opening }
GLMExamples class >> open [
	^ GLMExamplesBrowser new 
		title: self title;
		openOn: self
]

{ #category : #accessing }
GLMExamples class >> title [
	^ 'Examples'
]
