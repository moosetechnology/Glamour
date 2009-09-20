Class {
	#name : #GLMCodeBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMCodeBrowser class >> defaultEnvironment [
	^ GLMSTModel defaultEnvironment
]

{ #category : #opening }
GLMCodeBrowser class >> open [
	^ self new
		open
]

{ #category : #accessing }
GLMCodeBrowser >> browser [
	^ browser ifNil: [self buildBrowser. browser]
]

{ #category : #building }
GLMCodeBrowser >> buildBrowser [
	browser := GLMTableLayoutBrowser new.
	browser title: 'Glamorous ST Browser'.
	self layout.
	self onPackages.
	self onClassesFromPackages.
	self onInstVarsFromClasses.
	self onMethodsFromClasses.
	self onMethodsFromInstVars.
	self onDetailsFromPackagesFromClassesFromMethods.
	browser sendTo: #outer->#focusOnMethod from: #details->#focusOnMethod with: [:m | m ].
	browser sendTo: #packages->#selection from: #outer->#focusOnMethod with: [:method | method glmBehavior glmPackage].
	browser sendTo: #classes->#selection from: #outer->#focusOnMethod with: [:method | method glmBehavior ].
	browser sendTo: #methods->#selection from: #outer->#focusOnMethod with: [:method | method ]
]

{ #category : #building }
GLMCodeBrowser >> layout [
	browser
		column: #packages;
		column: [:c | c row: #classes; row: #instVars ];
		column: [:c | c row: #methods; row: #details] span: 3.
]

{ #category : #building }
GLMCodeBrowser >> onClassesFromPackages [
	browser
		showOn: #classes; from: #packages;
		using: [browser tree
					when: [:package | package isCollection not];
					display: [:package | package allClasses];
					children: [ :each | each traits ];
					icon: [ :each | 
						each stBehavior theNonMetaClass browserIcon isNil ifFalse: 
							[ OBMorphicIcons iconNamed: each stBehavior theNonMetaClass browserIcon ]
						ifTrue: [ nil ] ];
					format: [:class | class name]]
]

{ #category : #building }
GLMCodeBrowser >> onDetailsFromPackagesFromClassesFromMethods [
	browser
		showOn: #details; from: #classes; from: #methods; from: #packages; 
		using: [
			browser text
					forSmalltalk: [:class | class stBehavior ];
					title: 'Method';
					display: [:class :method | method sourceCode ].
			browser text
					forSmalltalk;
					title: 'Class';
					useExplicitNotNil;
					when: [:class | class notNil ];
					display: [:class | class definition ].
			browser list
					title: 'References';
					useExplicitNotNil;
					when: [:class | class notNil ];
					display: [:class | class references];
					format: [:each | each glmBehavior name, '>>', each name];
					update: #focusOnMethod on: $f entitled: 'Focus' with: [:list | list selection ].
			browser list
					title: 'Senders';
					display: [:class :method | method senders];
					format: [:each | each glmBehavior name, '>>', each name].
			browser list
					title: 'Implementors';
					display: [:class :method | method implementors];
					format: [:each | each glmBehavior name, '>>', each name]
		]
]

{ #category : #building }
GLMCodeBrowser >> onInstVarsFromClasses [
	browser showOn: #instVars; from: #classes; using: [ 
		browser tree
				display: [ :class | class instVars ];
				tags: [ :each | 
					{ each glmBehavior isMetaSide ifTrue: ['META'] ifFalse: ['INST'] } ] ]
]

{ #category : #building }
GLMCodeBrowser >> onMethodsFromClasses [
	browser showOn: #methods; from: #classes; using: [ 
		browser tree
				display: [ :class | class instanceAndMetaMethods ];
				tags: [ :each | 
					{each glmCategory name.
					each glmBehavior isMetaSide ifTrue: ['META'] ifFalse: ['INSTANCE']} ] ]
]

{ #category : #building }
GLMCodeBrowser >> onMethodsFromInstVars [
	browser showOn: #methods; from: #instVars; using: [ 
		browser tree
				display: [ :var | var accessingMethods ];
				tags: [ :each | 
					{each glmCategory name.
					each glmBehavior isMetaSide ifTrue: ['META'] ifFalse: ['INSTANCE']} ] ]
]

{ #category : #building }
GLMCodeBrowser >> onPackages [
	browser
		showOn: #packages;
		using: 
			[ browser tree
				children: [ :package | package subPackages ];
				format: [ :package | package name ] ]
]

{ #category : #opening }
GLMCodeBrowser >> open [
	^ self browser openOn: (GLMSTPackage rootPackagesOn: self class defaultEnvironment)
]
