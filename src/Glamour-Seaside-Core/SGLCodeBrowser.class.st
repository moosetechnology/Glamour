Class {
	#name : #SGLCodeBrowser,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #initialization }
SGLCodeBrowser class >> initialize [
	self registerAsApplication: 'glamour/code'
]

{ #category : #accessing }
SGLCodeBrowser >> browser [
	| browser |
	browser := GLMTableLayoutBrowser new.   

	browser row: [ :row | row column: #classes; column: #selectors ].
	browser row: #source.

	browser showOn: #classes; using: [
		browser tree
			title: 'Tree';
			children: [ :class | class subclasses ].
		browser mondrian
			title: 'Mondrian';
			painting: [ :view :class |
				view nodeShape size: 10. 
				view nodes: class withAllSubclasses.
				view edgesFrom: #superclass. 
				view treeLayout ] ].
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
SGLCodeBrowser >> model [
	^ Collection
]
