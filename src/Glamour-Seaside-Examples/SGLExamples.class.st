Class {
	#name : #SGLExamples,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #accessing }
SGLExamples >> browser [
	| browser |
	browser := GLMTabulator new.
	browser title: self title.
	browser
		column: #titles;
		column: #example span: 4.
	(browser transmit)
		to: #titles;
		andShow: [ :a | 
					(a list)
						sorted: [ :e1 :e2 | (e1 argumentAt: 1) < (e2 argumentAt: 1) ];
						format: [ :each | each argumentAt: 1 ] ].
	(browser transmit)
		from: #titles;
		to: #example;
		andShow: [ :a | 
					(a dynamic)
						title: 'Browser';
						presentation: [ :some :each | some custom: ((self browserFromPragma: each) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false)) ].
					(a text)
						title: 'Source code';
						forSmalltalk: self class;
						display: [ :each | self sourceFromPragma: each ] ].
	^ browser
]

{ #category : #accessing }
SGLExamples >> browserFromPragma: pragma [
	^ self class new perform: pragma selector
]

{ #category : #accessing }
SGLExamples >> model [
	^ Pragma allNamed: #glmBrowser:input: in: self class
]

{ #category : #accessing }
SGLExamples >> sourceFromPragma: each [
	^ self class sourceCodeAt: each selector
]
