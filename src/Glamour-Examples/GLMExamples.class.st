Class {
	#name : #GLMExamples,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMExamples class >> allExamples [
	^ Pragma allNamed: #glmBrowser:input: in: self.
]

{ #category : #accessing }
GLMExamples class >> browser [
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
						title: 'Examples';
						display: [ :list | list ];
						sorted: [ :x :y | (x argumentAt: 1) < (y argumentAt: 1) ];
						format: [ :each | each argumentAt: 1 ] ].
	(browser transmit)
		to: #example;
		from: #titles;
		andShow: [ :a | 
					(a dynamic)
						title: 'Browser';
						presentation: [ :some :each | some custom: (self exampleBrowserForPragma: each) ].
					(a text)
						title: 'Source code';
						act: [ :text :pragma | StandardToolSet browse: self selector: pragma selector ]
							icon: GLMUIThemeExtraIcons glamorousBrowse
							entitled: 'Browse';
						forSmalltalk: self;
						doItReceiver: [:pragma | self ];
						display: [ :pragma | self sourceCodeAt: pragma selector ] ].
	^ browser
]

{ #category : #accessing }
GLMExamples class >> exampleBrowserForPragma: each [
	^ (self new perform: each selector) startOn: (Compiler evaluate: (each argumentAt: 2) logged: false)
]

{ #category : #rendering }
GLMExamples class >> open [
	^ self browser openOn: self allExamples
]

{ #category : #accessing }
GLMExamples class >> title [
	^ 'Examples'
]
