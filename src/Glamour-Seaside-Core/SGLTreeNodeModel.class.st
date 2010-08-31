Class {
	#name : #SGLTreeNodeModel,
	#superclass : #Object,
	#instVars : [
		'item',
		'containerTree',
		'parentNode',
		'childrens',
		'expanded',
		'rendered',
		'htmlId'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #'instance creation' }
SGLTreeNodeModel class >> with: anObject [
	^ self new item: anObject 
]

{ #category : #accessing }
SGLTreeNodeModel >> childrenItems [
	^ childrens ifNil: [ 
		| allContents |
		allContents :=  (self containerTree glamourPresentation childrenValueOf: self item atLevel: self path size) ifNil: [OrderedCollection new].
		childrens := allContents collect: [ :d | 
			(self class with: d)
				parentNode: self;
				containerTree: self containerTree;
				yourself ] ].
	
]

{ #category : #accessing }
SGLTreeNodeModel >> containerTree [
	^ containerTree
]

{ #category : #accessing }
SGLTreeNodeModel >> containerTree: anObject [
	containerTree := anObject 
]

{ #category : #accessing }
SGLTreeNodeModel >> contents [
	^ self childrenItems select: [ :each | each shouldBeDisplayed ] 
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> displayText [
	^self containerTree glamourPresentation formatedDisplayValueOf: self item
]

{ #category : #accessing }
SGLTreeNodeModel >> expanded [
	^ expanded ifNil: [ expanded := self containerTree shouldAllExpand or: [ self path size == 1 and: [self containerTree shouldRootsExpand ] ] ]
]

{ #category : #accessing }
SGLTreeNodeModel >> expanded: aBoolean [
	expanded := aBoolean 
]

{ #category : #accessing }
SGLTreeNodeModel >> htmlId [
	^ htmlId
]

{ #category : #accessing }
SGLTreeNodeModel >> htmlIdIfNotNil: anObject [
	htmlId ifNil: [htmlId := anObject]
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> item [ 
	^ item
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> item: anObject [
	item := anObject 
]

{ #category : #accessing }
SGLTreeNodeModel >> parentNode [
	^ parentNode 
]

{ #category : #accessing }
SGLTreeNodeModel >> parentNode: aNode [
	^ parentNode:= aNode 
]

{ #category : #accessing }
SGLTreeNodeModel >> path [
	"Build the list of nodes to the root"
	
	|aCollection|
	aCollection := OrderedCollection new.
	self parentNode ifNotNil: [
		(aCollection includes: self parentNode)
			ifFalse: [aCollection addAll: self parentNode path ] ].
	aCollection add: self.
	^ aCollection
]

{ #category : #accessing }
SGLTreeNodeModel >> rendered [
	^ rendered ifNil: [rendered := false]
]

{ #category : #accessing }
SGLTreeNodeModel >> rendered: anObject [
	rendered := anObject
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> shouldBeDisplayed [
	^ self shouldBeDisplayedByTags
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> shouldBeDisplayedByTags [
	| nodeTags |
	self containerTree tagsToFilterBy isEmpty ifTrue: [ ^ true ].
	self withContentsDo: [ :node | 
		nodeTags := self containerTree glamourPresentation tagsFor: node item to: #filter.
		(self containerTree tagsToFilterBy allSatisfy: [ :each | nodeTags includes: each ])
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> toggleExpansion [
	self expanded 
		ifTrue: [self expanded: false] 
		ifFalse: [self expanded: true]
]

{ #category : #'as yet unclassified' }
SGLTreeNodeModel >> withContentsDo: aBlock [
	self flag: 'if the tree is infinite due to recursion, this might not stop'.
	aBlock value: self.
	self contents do: [:each | each withContentsDo: aBlock ]
]
