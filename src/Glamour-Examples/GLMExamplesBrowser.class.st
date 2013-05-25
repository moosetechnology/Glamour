"
self new browser openOn: GLMBasicExamples
"
Class {
	#name : #GLMExamplesBrowser,
	#superclass : #GLMCompositePresentation,
	#category : #'Glamour-Examples'
}

{ #category : #building }
GLMExamplesBrowser >> compose [
	"self new openOn: GLMBasicExamples"

	self tabulator with: [:browser | 
		browser
			column: #titles;
			column: #example span: 4.
		browser transmit
			to: #titles;
			andShow: [ :a | self exampleListIn: a ].
		browser transmit
			to: #example;
			fromOutsidePort: #entity;
			from: #titles;
			andShow: [ :a | self exampleIn: a ] ]
]

{ #category : #private }
GLMExamplesBrowser >> exampleBrowserForPragma: each in: aClass [
	| exampleBrowser wrapperBrowser |
	exampleBrowser := aClass new perform: each selector.

	wrapperBrowser := GLMTabulator new.
	wrapperBrowser column: #theOuterPane.
	wrapperBrowser transmit
		fromOutsideEntityPort; 
		to: #theOuterPane;
		andShow: [:a | 
			a custom: exampleBrowser ].
	^ wrapperBrowser startOn: (Compiler evaluate: (each argumentAt: 2) logged: false)
]

{ #category : #building }
GLMExamplesBrowser >> exampleIn: composer [
	composer dynamic
		title: 'Browser';
		display: [ :exampleClass :examplePragma | self exampleBrowserForPragma: examplePragma in: exampleClass ];
		act: [ :dynamic | 
				dynamic cachedPresentation presentations first panes first presentations first openTree ] 
			entitled: 'View browser tree'.
	composer smalltalkCode
		title: 'Source code';
		act: [ :text :exampleClass :examplePragma | Smalltalk tools browser fullOnClass: exampleClass selector: examplePragma selector ]
			icon: GLMUIThemeExtraIcons glamorousBrowse
			entitled: 'Browse';
		smalltalkClass: [ :exampleClass | exampleClass ];
		doItReceiver: [ :exampleClass | exampleClass ];
		display: [ :exampleClass :pragma | exampleClass sourceCodeAt: pragma selector ]
]

{ #category : #building }
GLMExamplesBrowser >> exampleListIn: a [
	^ a list
		title: 'Examples';
		display: [ :exampleClass | exampleClass allExamples ];
		sorted: [ :x :y | (x argumentAt: 1) < (y argumentAt: 1) ];
		format: [ :each | each argumentAt: 1 ]
]
