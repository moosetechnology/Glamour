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
	browser title: 'No Category Code Browser'.
	self layout.
	self onPackages.
	self onClassesFromPackages.
	self onMethodsFromClasses.
	self onDetailsFromPackagesFromClassesFromMethods.
]

{ #category : #building }
GLMCodeBrowser >> layout [
	browser
		column: #packages;
		column: [:c | c row: #classes; row: #methods span: 2 ] span: 2;
		column: #details span: 3.
]

{ #category : #building }
GLMCodeBrowser >> onClassesFromPackages [
	browser
		showOn: #classes; from: #packages;
		using: [browser tree
					when: [:package | package isCollection not];
					display: [:package | package classes];
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
					
		]
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
