Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMExamples class >> browseExamples [
	"self browseExamples"
	| browser pragmas |
	pragmas := Pragma 
		allNamed: #glmBrowser:input:
		in: self.
	browser := GLMTabulator new.
	browser title: self name asString.
	browser column: #titles; column: #example span: 4.
	browser showOn: #titles; using: [
		browser list
			format: [:each | each argumentAt: 1]].
	browser showOn: #example; from: #titles; using: [
		browser dynamic
			display: [:each | (self new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false)]].
	browser openOn: pragmas.
]
