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

{ #category : #callbacks }
GLMTreeMorphNodeModel >> buttonForTag: each [ 
	| button oldLabel m |
	button := SimpleButtonMorph new.
	(oldLabel := button findA: StringMorph) ifNotNil: [ oldLabel delete ].
	m := StringMorph 
		contents: each
		font: (LogicalFont 
				familyName: UITheme current buttonFont familyName
				pointSize: UITheme current buttonFont pointSize - 2).
	button extent: (m width + 6) @ m height.
	m position: 3 @ 0.	"button center - (m extent // 2)"
	m lock.
	button
		addMorph: m;
		borderStyle: (BorderStyle inset width: 1);
		borderColor: Color gray;
		target: self;
		actionSelector: #toggleFilteringByTag:;
		arguments: (Array with: each);
		useRoundedCorners.
	(self containerTree shouldFilterByTag: each) 
		ifFalse: 
			[ m color: Color white.
			button color: Color gray ]
		ifTrue: 
			[ m color: Color darkGray.
			button color: Color veryLightGray ].
	^ button
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> childrenItems [
	^ self containerTree childrenBlock glamourValue: self item
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
	self containerTree changed: {#roots. #openItemPath}, (self path collect: [:each | each item]).
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> icon [
	^ self containerTree glamourPresentation iconFor: self item
]

{ #category : #testing }
GLMTreeMorphNodeModel >> itemHasTags: aCollection [ 
	^ aCollection allSatisfy: 
		[ :each | 
		(self containerTree glamourPresentation tagsFor: self item) includes: each ]
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

{ #category : #callbacks }
GLMTreeMorphNodeModel >> rowMorphListFor: aContainer [ 
	| row |
	row := OrderedCollection with: (UITheme current newRowIn: World for: { self displayText }).
	(self containerTree glamourPresentation tagsFor: self item) do: [ :each | 
			row addLast: (self buttonForTag: each) ].
	^ row
]

{ #category : #callbacks }
GLMTreeMorphNodeModel >> toggleFilteringByTag: aTag [ 
	self containerTree toggleFilteringByTag: aTag
]

{ #category : #enumerating }
GLMTreeMorphNodeModel >> withContentsDo: aBlock [
	self flag: 'if the tree is infinite due to recursion, this might not stop'.
	aBlock value: self.
	self contents do: [:each | each withContentsDo: aBlock ]
]
