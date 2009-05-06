Class {
	#name : #GLMTreeModel,
	#superclass : #GLMMorphicModel,
	#instVars : [
		'roots',
		'selection',
		'childrenBlock',
		'onSelection',
		'displaySelector'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMTreeModel >> childrenBlock [
	^childrenBlock
]

{ #category : #accessing }
GLMTreeModel >> childrenBlock: aBlock [
	childrenBlock := aBlock
]

{ #category : #accessing }
GLMTreeModel >> displaySelector: aSymbol [
	displaySelector := aSymbol
]

{ #category : #callbacks }
GLMTreeModel >> geSelectionPath [
	^self selection
]

{ #category : #callbacks }
GLMTreeModel >> getChildrenOf: aNode [
	^childrenBlock value: aNode
]

{ #category : #callbacks }
GLMTreeModel >> getLabelOf: anObject [
	^ displaySelector glamourValue: anObject
]

{ #category : #callbacks }
GLMTreeModel >> hasChildren: aNode [
	^(self getChildrenOf: aNode) notEmpty
]

{ #category : #private }
GLMTreeModel >> nodeAt: pathCollection [
	^self nodeAt: pathCollection allButFirst for: self roots
]

{ #category : #private }
GLMTreeModel >> nodeAt: pathCollection for: childrenCollection [
	| node |
	node := childrenCollection at: pathCollection first.
	^pathCollection size > 1 ifTrue: [self nodeAt: pathCollection allButFirst for: (childrenBlock value: node)] ifFalse: [node]
]

{ #category : #accessing }
GLMTreeModel >> onSelection: aBlock [
	onSelection := aBlock
]

{ #category : #callbacks }
GLMTreeModel >> roots [
	^roots
]

{ #category : #accessing }
GLMTreeModel >> roots: aCollectionOrElement [
	roots := aCollectionOrElement isCollection ifTrue: [aCollectionOrElement] ifFalse: [OrderedCollection with: aCollectionOrElement]
]

{ #category : #accessing }
GLMTreeModel >> selection [
	^selection
]

{ #category : #callbacks }
GLMTreeModel >> selection: aNode [
     selection := aNode.
	onSelection ifNotNil: [onSelection value: aNode].
	self changed: #selection.
]
