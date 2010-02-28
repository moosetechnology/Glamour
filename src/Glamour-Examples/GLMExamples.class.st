Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMExamples class >> browseExamples [
	"self browseExamples"
	| browser pragmas |
	pragmas := Pragma allNamed: #glmBrowser:input: in: self.
	browser := GLMTabulator new.
	browser title: self title.
	browser column: #titles; column: #example span: 4.
	browser showOn: #titles; using: [
		browser list
			display: [:list | list asSortedCollection: [:a :b | 
				(a argumentAt: 1) < (b argumentAt: 1)] ];
			format: [:each | each argumentAt: 1]].
	browser showOn: #example; from: #titles; using: [
		browser dynamic
			title: 'Browser';
			presentation: [ :some :each | 
				some custom: ((self new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false))].
		browser text 
			title: 'Source code';
			forSmalltalk: self;
			display: [:each | self sourceCodeAt: each selector]].	
	^ browser openOn: pragmas.
]

{ #category : #'as yet unclassified' }
GLMExamples class >> open [
	^ self browseExamples
]

{ #category : #'as yet unclassified' }
GLMExamples class >> title [
	^ 'Examples'
]
