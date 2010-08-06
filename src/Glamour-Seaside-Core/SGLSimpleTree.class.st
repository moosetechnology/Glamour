Class {
	#name : #SGLSimpleTree,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLSimpleTree class >> initialize [
	self registerAsApplication: 'glamour/tree/simpleTreePresentation'
]

{ #category : #accessing }
SGLSimpleTree >> browser [
	|browser|

	browser := GLMTabulator new.
	browser column: #one.
	browser showOn: #one; using: [
		browser tree
			title: 'No expansion';
			children: [:item | 1 to: 4];
			showOnly: 10.
		browser tree
			title: 'Roots expanded';
			rootsExpanded;
			children: [:item | 1 to: 4];
			showOnly: 10 ].

	^ browser
]

{ #category : #accessing }
SGLSimpleTree >> model [
	^ 1 to: 100
]
