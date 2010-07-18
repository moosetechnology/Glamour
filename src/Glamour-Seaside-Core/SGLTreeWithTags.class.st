Class {
	#name : #SGLTreeWithTags,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'as yet unclassified' }
SGLTreeWithTags class >> initialize [
	self registerAsApplication: 'glamour/tags/treeWithTags'
]

{ #category : #'as yet unclassified' }
SGLTreeWithTags >> browser [
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			title: 'No expansion';
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{each even ifTrue: ['even'] ifFalse: ['odd'] } ]
				ifFalse: [
					{each size even ifTrue: ['even'] ifFalse: ['odd'] } ] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ].
			
		browser tree
			title: 'All Expanded';
			allExpanded;
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{each even ifTrue: ['even'] ifFalse: ['odd'] } ]
				ifFalse: [
					{each size even ifTrue: ['even'] ifFalse: ['odd'] } ] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #'as yet unclassified' }
SGLTreeWithTags >> model [
	^ #(
			(1 2 3 4) 
			(5 6 7 (8 9 99) (10 11) ( (12 13) (13 15) ) )
			 (16 17 18  (19 20 21 22) (23 24 25 26))
		)
]
