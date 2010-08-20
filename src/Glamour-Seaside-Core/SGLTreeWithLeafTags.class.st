Class {
	#name : #SGLTreeWithLeafTags,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples-Dev'
}

{ #category : #'instance creation' }
SGLTreeWithLeafTags class >> initialize [
	self registerAsApplication: 'glamour/tags/treeWithLeafTags'
]

{ #category : #accessing }
SGLTreeWithLeafTags >> browser [
	"self new browser openOn: self new model"

	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser showOn: #one; using: [
		browser tree
			beMultiple;
			title: 'No expansion';
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ].
			
			
		browser tree
			title: 'All Expanded';
			allExpanded;
			tags: [:each | 
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser showOn: #two; from: #one; using: [ browser text ].
	^ browser
]

{ #category : #accessing }
SGLTreeWithLeafTags >> model [
	^ #(
			(1 2 3 4) 
			(5 6 7 (8 9) (10 11) ( (12 13) (13 15) ) )
			 (16 17 18  (19 20 21 22))
		)
]
