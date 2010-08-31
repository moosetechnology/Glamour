Class {
	#name : #SGLExamples,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #accessing }
SGLExamples class >> applicationUrl [
	self subclassResponsibility
]

{ #category : #'instance creation' }
SGLExamples class >> initialize [
	self registerAsApplication: self applicationUrl
]

{ #category : #accessing }
SGLExamples >> browser [
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
				some custom: ((self class new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false))].
		browser text 
			title: 'Source code';
			forSmalltalk: self class;
			display: [:each | self class sourceCodeAt: each selector]].	
	^ browser
]

{ #category : #accessing }
SGLExamples >> model [
	^ Pragma allNamed: #glmBrowser:input: in: self class
]
