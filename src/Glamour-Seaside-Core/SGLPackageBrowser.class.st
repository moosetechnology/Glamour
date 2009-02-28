Class {
	#name : #SGLPackageBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLPackageBrowser class >> initialize [
	self registerAsApplication: 'glamour/package'
]

{ #category : #accessing }
SGLPackageBrowser >> browser [
	| browser |

	" browser "
	browser := GLMTableLayoutBrowser new.
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
SGLPackageBrowser >> categoriesOn: browser [
	browser showOn: #category; using: [
		browser list
			display: [ :environment | environment categories ] ]
]

{ #category : #building }
SGLPackageBrowser >> classesOn: browser [
	browser showOn: #class; from: #outer -> #entity; from: #category; using: [
		browser list
			title: 'Instance';
			display: [ :environment :category | 
				((environment classes select: [ :each | each isMeta not ])
					select: [ :each | each category = category ])
					asSortedCollection: [ :a :b | a name < b name ] ];
			format: [ :class | class name ].
		browser list
			title: 'Class';
			display: [ :environment :category | 
				((environment classes select: [ :each | each isMeta ])
					select: [ :each | each theNonMetaClass category = category ])
					asSortedCollection: [ :a :b | a name < b name ] ];
			format: [ :class | class theNonMetaClass name ] ]
]

{ #category : #accessing }
SGLPackageBrowser >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]

{ #category : #building }
SGLPackageBrowser >> protocolsOn: browser [
	browser showOn: #protocol; from: #outer -> #entity; from: #class; using: [
		browser list
			when: [ :environment :class | class notNil ];
			display: [ :environment :class | 
				(environment protocolsFor: class)
					asSortedCollection ] ]
]

{ #category : #building }
SGLPackageBrowser >> selectorsOn: browser [
	browser showOn: #selector; from: #outer -> #entity; from: #class; from: #protocol; using: [
		browser list
			when: [ :environment :class :protocol | class notNil and: [ protocol notNil ] ];
			display: [ :environment :class :protocol | environment selectorsFor: protocol in: class ].
		browser list
			when: [ :environment :class :protocol | class notNil and: [ protocol isNil ] ];
			display: [ :environment :class :protocol | environment selectorsForClass: class ] ]
]

{ #category : #building }
SGLPackageBrowser >> sourceOn: browser [
	browser showOn: #source; from: #class; from: #selector; using: [
		browser text
			when: [ :class :selector | class notNil and: [ selector notNil ] ];
			display: [ :class :selector | class sourceCodeAt: selector ifAbsent: [ String new ] ].
		browser text
			when: [ :class :selector | class notNil and: [ selector isNil ] ];
			display: [ :class :selector | class definition ] ]
]
