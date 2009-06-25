Class {
	#name : #SGLSimpleBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLSimpleBrowser class >> initialize [
	self registerAsApplication: 'glamour/codebrowser'
]

{ #category : #accessing }
SGLSimpleBrowser >> browser [
	| browser |
	browser := GLMTableLayoutBrowser new.   

	browser row: [ :row | row column: #classes; column: #selectors ].
	browser row: #source.

	browser showOn: #classes; using: [
		browser tree
			children: [ :class | class subclasses ] ].
	browser showOn: #selectors; from: #classes; using: [
		browser list 
			display: [ :class | class selectors asSortedCollection ] ].

	browser showOn: #source; from: #classes; from: #selectors; using: [
		browser text
			title: 'Source';
			when: [ :class :selector | class notNil and: [ selector notNil ] ];
			display: [ :class :selector | class sourceCodeAt: selector ].
		browser text
			title: 'Comment';
			display: [ :class :selector | class comment ] ].
		
	^ browser
]

{ #category : #accessing }
SGLSimpleBrowser >> model [
	^ Object
]
