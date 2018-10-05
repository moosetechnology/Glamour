Class {
	#name : #SGLTreeWithLeafTags,
	#superclass : #SGLComponent,
	#category : #'Glamour-Seaside-Examples'
}

{ #category : #'as yet unclassified' }
SGLTreeWithLeafTags class >> initialize [
	self registerAsApplication: 'glamour/development/treeWithLeafTags'
]

{ #category : #'as yet unclassified' }
SGLTreeWithLeafTags >> browser [
	"self new browser openOn: self new model"
	|browser |
	browser := GLMTabulator new.
	browser column: #one; column: #two.
	browser transmit to: #one; andShow: [ :composite |
		composite tree
			title: 'None Expanded';
			allowDeselection;
			beMultiple;
			showOnly: 8;
			tags: [:each |
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ].
		composite tree
			title: 'Roots Expanded';
			rootsExpanded;
			showOnly: 4;
			allowDeselection;
			beMultiple;
			tags: [:each |
				each isNumber 
				ifTrue: [
					{(each isNumber and: [each even]) ifTrue: ['even'] ifFalse: ['odd'].
					(each isNumber and: [each\\3 == 0] ) ifTrue: ['div 3'] ifFalse: ['not div 3'].
					(each isNumber and: [each\\4 == 0] ) ifTrue: ['div 4'] ifFalse: ['not div 4'].
					(each isNumber and: [each\\5 == 0] ) ifTrue: ['div 5'] ifFalse: ['not div 5']} ]
				ifFalse: [{}] ];
			children: [:x :i | x isCollection ifTrue: [x] ifFalse: [OrderedCollection new] ] ].
	browser transmit to: #two; from: #one; andShow: [ :composite |
		 composite text ].
	^ browser
]

{ #category : #'as yet unclassified' }
SGLTreeWithLeafTags >> model [
	^ #( 
		(1 2 3 4) 
		(5 6 7 (8 9) (10 11) ( (12 13) (13 15 1) ) ) 
		(16 17 18  (19 20 21 22))  
		1 2 3 4 5 6 7 8 
		(9 10 11 12) 
		(13 14 15 16 1)
		(17 18 (19  1 20 22 22) 23 24 )
		25 26 27 28 29)
]
