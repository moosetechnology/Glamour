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
		contents := (self childrenItems collect: [:d | self class with: d]) do: [:c | 
			c parentNode: self; containerTree: self containerTree ] ]
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

{ #category : #accessing }
GLMTreeMorphNodeModel >> icon [
	^ nil
]

{ #category : #menu }
GLMTreeMorphNodeModel >> keyStroke: aCharacter from: aTreeMorph [ 
	^ false

]

{ #category : #menu }
GLMTreeMorphNodeModel >> menu: menu shifted: b [ 

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
	self parentNode
		ifNotNil: [(aCollection includes: self parentNode)
		ifFalse: [self parentNode pathIn: aCollection]].
	aCollection add: self.
	^ aCollection
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> rowMorphListFor: aContainer [ 
	^ OrderedCollection 
		with: (UITheme current newRowIn: World for: {self displayText})
]
