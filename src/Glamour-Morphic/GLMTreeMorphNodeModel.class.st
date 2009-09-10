Class {
	#name : #GLMTreeMorphNodeModel,
	#superclass : #ListItemWrapper,
	#instVars : [
		'parentNode',
		'contents',
		'containerTree',
		'onSelection'
	],
	#category : #'Glamour-Morphic'
}

{ #category : #accessing }
GLMTreeMorphNodeModel >> childrenItems [
	^ self containerTree childrenBlock glamourValue: self item
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> classButtonRow [
	^ UITheme current newRowIn: World for: {self displayText}
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> containerTree [
	^ containerTree
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> containerTree: anObject [
	containerTree := anObject
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> contents [
	^ contents ifNil: [
		contents := self childrenItems collect: [:d | 
			(self class with: d) 
				parentNode: self;
				containerTree: self containerTree;
				yourself ] ]
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> displayText [
	^ UITheme current 
		newTextIn: World
		text: (self containerTree glamourPresentation formatedDisplayValueOf: self item) 
]

{ #category : #testing }
GLMTreeMorphNodeModel >> enabled [
	^ true
]

{ #category : #menu }
GLMTreeMorphNodeModel >> executeMenuAction: anAction [
	self containerTree announce: (GLMMenuItemSelected action: anAction)
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> expandParentPath [
"	self containerTree changed: {#roots. #openItemPath}, (self path collect: [:each | each item])."
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> icon [
	^ nil
]

{ #category : #menu }
GLMTreeMorphNodeModel >> keyStroke: aCharacter from: aTreeMorph [ 
	^ false

]

{ #category : #menu }
GLMTreeMorphNodeModel >> menu: aMenuMorph shifted: b [ 
	| subMenus targetMenuMorph subMenu |
	subMenus := Dictionary new.
	self containerTree allMenuActions do: [ :action |
		targetMenuMorph := action category notNil 
			ifTrue: [ subMenus at: action category ifAbsentPut: [ 
					subMenu :=  MenuMorph new.
					aMenuMorph add: action category subMenu: subMenu.
					subMenu ] ]
			ifFalse: [ aMenuMorph ].
		targetMenuMorph 
			add: action title
			target: self
			selector: #executeMenuAction:
			argument: action ].
	^ aMenuMorph
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> parentNode [
	^ parentNode
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> parentNode: aNode [
	parentNode := aNode
	
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> path [
	^ self pathIn: OrderedCollection new.
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> pathIn: aCollection [ 
	self parentNode ifNotNil: [
		(aCollection includes: self parentNode)
			ifFalse: [self parentNode pathIn: aCollection]].
	aCollection add: self.
	^ aCollection
]

{ #category : #printing }
GLMTreeMorphNodeModel >> printOn: aStream [
	aStream nextPutAll: 'a NodeModel with '.
	aStream nextPutAll: self item printString.
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> rowMorphListFor: aContainer [ 
	^ OrderedCollection 
		with: (UITheme current newRowIn: World for: {self displayText})
]

{ #category : #enumerating }
GLMTreeMorphNodeModel >> withContentsDo: aBlock [
	self flag: 'if the tree is infinite due to recursion, this might not stop'.
	aBlock value: self.
	self contents do: [:each | each withContentsDo: aBlock ]
]
