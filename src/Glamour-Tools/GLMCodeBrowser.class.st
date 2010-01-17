"
self open
"
Class {
	#name : #GLMCodeBrowser,
	#superclass : #GLMGlobalBrowserTemplate,
	#category : #'Glamour-Tools'
}

{ #category : #accessing }
GLMCodeBrowser class >> defaultEnvironment [
	^ GLMSTModel defaultEnvironment
]

{ #category : #building }
GLMCodeBrowser >> buildBrowser [
	browser := GLMTabulator new.
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

{ #category : #opening }
GLMCodeBrowser >> entity [ 
	^ GLMSTPackage rootPackagesOn: self class defaultEnvironment
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
					when: [:class :method | class notNil and: [method isNil]];
					display: [:class | class definition ].
			browser list
					title: 'References';
					useExplicitNotNil;
					when: [:class | class notNil ];
					display: [:class | class references];
					format: [:each | each glmBehavior name, '>>', each name];
					update: #focusOnMethod on: $f entitled: 'Jump there' with: [:list | list selection ].
			browser list
					title: 'Senders';
					display: [:class :method | method senders];
					format: [:each | each glmBehavior name, '>>', each name];
					update: #focusOnMethod on: $f entitled: 'Jump there' with: [:list | list selection ].
			browser list
					title: 'Implementors';
					display: [:class :method | method implementors];
					format: [:each | each glmBehavior name, '>>', each name];
					update: #focusOnMethod on: $f entitled: 'Jump there' with: [:list | list selection ].
		]
]

{ #category : #building }
GLMCodeBrowser >> onInstVarsFromClasses [
	browser showOn: #instVars; from: #classes; using: [ 
		browser list
				display: [ :class | class instVars ];
				tags: [ :each | 
					{ each glmBehavior isMetaSide ifTrue: ['META'] ifFalse: ['INST'] } ] ]
]

{ #category : #building }
GLMCodeBrowser >> onMethodsFromClasses [
	browser transmit to: #methods; from: #classes; andShow: [ :a | 
		a accordionArrangement.
		a list
				title: 'Instance';
				display: [ :class | class methods ];
				tags: [ :each | 
					{each glmCategory name} ].
		a list
				title: 'Meta';
				display: [ :class | class metaSide methods ];
				tags: [ :each | 
					{each glmCategory name} ].
		 ]
]

{ #category : #building }
GLMCodeBrowser >> onMethodsFromInstVars [
	browser showOn: #methods; from: #instVars; using: [ 
		browser list
				display: [ :var | var accessingMethods ];
				tags: [ :each | 
					{each glmCategory name.
					each glmBehavior isMetaSide ifTrue: ['META'] ifFalse: ['INST']} ] ]
]

{ #category : #building }
GLMCodeBrowser >> onPackages [
	browser
		showOn: #packages;
		using: 
			[ browser tree
				children: [ :package | package subPackages ];
				format: [ :package | package name ];
				filterOn: [ :text :each | text match: each name ] ]
]
