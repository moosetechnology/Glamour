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
	browser 
		column: #classes; column: #selectors;
		row: #source span: 2.

	" classes "
	browser showOn: #classes; using: [
		browser list
			display: [ :environment | environment allClasses ];
			format: [ :each | each name ] ].

	" classes " 
	browser showOn: #selectors; from: #classes; using: [
		browser list
			display: [ :class | class selectors ];
			format: [ :each | each asString ] ].
		
	" source "
	browser showOn: #source; from: #classes; from: #selectors; using: [
		browser text
			"when: [ :class :selector | selector isNil ];"
			display: [ :class :selector | class definition ].
		browser text
			when: [ :class :selector | selector notNil ];
			display: [ :class :selector | class sourceCodeAt: selector ] ].

	^ browser
]
