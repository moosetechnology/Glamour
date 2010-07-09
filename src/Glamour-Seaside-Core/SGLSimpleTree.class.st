Class {
	#name : #SGLSimpleTree,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLSimpleTree class >> initialize [
	self registerAsApplication: 'glamour/tabulator/simpleTreePresentation'
]

{ #category : #'as yet unclassified' }
SGLSimpleTree >> browser [
	|browser|

	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			children: [:item | 1 to: 4];
			showOnly: 10 ].

	^ browser
]

{ #category : #'as yet unclassified' }
SGLSimpleTree >> model [
	^ 1 to: 100
]
