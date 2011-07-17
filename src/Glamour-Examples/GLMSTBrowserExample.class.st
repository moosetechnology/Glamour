Class {
	#name : #GLMSTBrowserExample,
	#superclass : #Object,
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMSTBrowserExample >> browser [
	"
	self new browser openOn: (BrowserEnvironment new forPackageNames: #('Glamour'))
	"

	| browser |

	browser := GLMTabulator new.
	browser row: [ :row | 
		row 
			column: #category;
			column: #class;
			column: #protocol;
			column: #selector ].
	browser row: #source.
	
	" categories "
	self categoriesOn: browser.
	self classesOn: browser.
	self protocolsOn: browser.
	self selectorsOn: browser.
	self sourceOn: browser.
	
	^ browser
]

{ #category : #building }
GLMSTBrowserExample >> categoriesOn: browser [
	browser showOn: #category; using: [
		browser list
			display: [ :environment | environment categories ] ]
]

{ #category : #building }
GLMSTBrowserExample >> classesOn: browser [
	browser
		showOn: #class;
		from: #outer port: #entity;
		from: #category;
		using: [ 
					(browser list)
						title: 'Instance';
						display: [ :environment :category | (environment classes select: [ :each | each isMeta not ]) select: [ :each | each category = category ] ];
						sorted: [ :a :b | a name < b name ];
						format: [ :class | class name ].
					(browser list)
						title: 'Class';
						display: [ :environment :category | (environment classes select: [ :each | each isMeta ]) select: [ :each | each theNonMetaClass category = category ] ];
						sorted: [ :a :b | a name < b name ];
						format: [ :class | class theNonMetaClass name ] ]
]

{ #category : #accessing }
GLMSTBrowserExample >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]

{ #category : #building }
GLMSTBrowserExample >> protocolsOn: browser [
	browser
		showOn: #protocol;
		from: #outer port: #entity;
		from: #class;
		using: [ 
					(browser list)
						when: [ :environment :class | class notNil ];
						display: [ :environment :class | environment protocolsFor: class ];
						sorted ]
]

{ #category : #building }
GLMSTBrowserExample >> selectorsOn: browser [
	browser
		showOn: #selector;
		from: #outer port: #entity;
		from: #class;
		from: #protocol;
		using: [ 
					(browser list)
						useExplicitNotNil;
						when: [ :environment :class :protocol | class notNil and: [ protocol notNil ] ];
						display: [ :environment :class :protocol | environment selectorsFor: protocol in: class ];
						sorted.
					(browser list)
						useExplicitNotNil;
						when: [ :environment :class :protocol | class notNil and: [ protocol isNil ] ];
						display: [ :environment :class :protocol | environment selectorsForClass: class ];
						sorted ]
]

{ #category : #building }
GLMSTBrowserExample >> sourceOn: browser [
	browser showOn: #source; from: #category; from: #class; from: #selector; using: [
		browser text
			title: 'Source';
			useExplicitNotNil;
			when: [ :category :class :selector | class notNil and: [ selector notNil ] ];
			display: [ :category :class :selector | class sourceCodeAt: selector ifAbsent: [ String new ] ].
		browser text
			title: 'Source';
			useExplicitNotNil;
			when: [ :category :class :selector | class notNil and: [ selector isNil ] ];
			display: [ :category :class :selector | class definition ].
		browser mondrian
			title: 'Complexity';
			useExplicitNotNil;
			painting: [ :view :category :class :selector |
				view nodeShape 
					height: [ :model | model linesOfCode min: 50 max: 5 ];
					width: [ :model | model instVarNames size + 5 ];
					fillColor: [ :model | model = class ifTrue: [ Color red ] ifFalse: [ Color white ] ].
				view nodes: (((Smalltalk organization listAtCategoryNamed: category)
					collect: [ :each | Smalltalk classNamed: each ])
					reject: [ :each | each isTrait ]).
				view edgesFrom: [ :each | each superclass ].
				view treeLayout ];
			when: [ :category :class :selector | category notNil ] ]
]
