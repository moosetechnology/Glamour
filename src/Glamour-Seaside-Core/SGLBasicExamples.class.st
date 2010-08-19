Class {
	#name : #SGLBasicExamples,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLBasicExamples class >> initialize [
	self registerAsApplication: 'glamour/basicExamples/all'
]

{ #category : #accessing }
SGLBasicExamples >> browser [
	"self browseExamples"
	| browser |
	browser := GLMTabulator new.
	browser title: 'Examples'.
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
				some custom: ((self wrappedClass new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false))].
		browser text 
			title: 'Source code';
			forSmalltalk: self wrappedClass;
			display: [:each | self wrappedClass sourceCodeAt: each selector]].	
	^ browser
]

{ #category : #accessing }
SGLBasicExamples >> model [
	^ Pragma allNamed: #glmBrowser:input: in: (self wrappedClass).
]

{ #category : #accessing }
SGLBasicExamples >> wrappedClass [
	^ GLMBasicExamples
]
