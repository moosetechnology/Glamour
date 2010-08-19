Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMExamples class >> browser [
	"self browseExamples"
	| browser |
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
	^ browser.
]

{ #category : #accessing }
GLMExamples class >> model [
	^ Pragma allNamed: #glmBrowser:input: in: self.
]

{ #category : #rendering }
GLMExamples class >> open [
	^ self browser openOn: self model
]

{ #category : #accessing }
GLMExamples class >> title [
	^ 'Examples'
]
