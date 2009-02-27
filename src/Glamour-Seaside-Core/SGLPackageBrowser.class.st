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
	browser column: #category; column: #class; column: #protocol; column: #selector.
	browser column: #source.
	
	" categories "
	browser showOn: #category; using: [
		browser list
			display: [ :environment | environment categories ] ].

	" classes "
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
			format: [ :class | class theNonMetaClass name ] ].

	" protocols "
	browser showOn: #protocol; from: #outer -> #entity; from: #class; using: [
		browser list
			when: [ :environment :class | class notNil ];
			display: [ :environment :class | 
				(environment protocolsFor: class)
					asSortedCollection ] ].

	" selectors " 
	browser showOn: #selector; from: #outer -> #entity; from: #class; from: #protocol; using: [
		browser list
			when: [ :environment :class :protocol | class notNil and: [ protocol notNil ] ];
			display: [ :environment :class :protocol | environment selectorsFor: protocol in: class ].
		browser list
			when: [ :environment :class :protocol | class notNil and: [ protocol isNil ] ];
			display: [ :environment :class :protocol | environment selectorsForClass: class ] ].
		
	" source "
	browser showOn: #source; from: #class; from: #selector; using: [
		browser text
			when: [ :class :selector | selector notNil ];
			display: [ :class :selector | class sourceCodeAt: selector ].
		browser text
			when: [ :class :selector | selector isNil ];
			display: [ :class :selector | class definition ] ].

	^ browser
]

{ #category : #accessing }
SGLPackageBrowser >> model [
	^ BrowserEnvironment new forPackageNamed: 'Glamour'
]
