Class {
	#name : #SGLExamples,
	#superclass : #WAComponent,
	#category : #'Glamour-Seaside'
}

{ #category : #examples }
SGLExamples >> classNavigator [
	" self new classNavigator openOn: (BrowserEnvironment new forPackageNamed: 'Glamour') "

	| browser |
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
			display: [ :environment :category | 
				(environment classes select: [ :each | each isMeta not ])
					select: [ :each | each category = category ] ];
			format: [ :class | class name ].
		browser list
			display: [ :environment :category | 
				(environment classes select: [ :each | each isMeta ])
					select: [ :each | each theNonMetaClass category = category ] ];
			format: [ :class | class theNonMetaClass name ] ].

	" protocols "
	browser showOn: #protocol; from: #outer -> #entity; from: #class; using: [
		browser list
			when: [ :environment :class | class notNil ];
			display: [ :environment :class | environment protocolsFor: class ] ].

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
			when: [ :class :selector | selector isNil ];
			display: [ :class :selector | class definition ].
		browser text
			when: [ :class :selector | selector notNil ];
			display: [ :class :selector | class sourceCodeAt: selector ] ].

	^ browser
]
