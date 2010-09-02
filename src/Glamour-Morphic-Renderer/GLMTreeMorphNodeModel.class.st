Class {
	#name : #GLMTreeMorphNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'contents',
		'containerTree',
		'onSelection'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #callbacks }
GLMTreeMorphNodeModel >> buttonForTag: each filter: filter [
	| button |

	button := GLMMorphic 
		togglingButtonLabelled: each
		pressed: (self containerTree shouldFilterByTag: filter)
		style: self containerTree glamourPresentation tagsStyle.
	button
		target: self;
		actionSelector: #toggleFilteringByTag:;
		arguments: (Array with: filter).
	^ button
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> childrenItems [
	^ (self containerTree glamourPresentation childrenValueOf: self item atLevel: self path size) ifNil: [OrderedCollection new]
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
	| allContents |
	^ contents ifNil: 
		[ allContents := self childrenItems collect: [ :d | 
			(self class with: d)
				parentNode: self;
				containerTree: self containerTree;
				yourself ].
		contents := allContents select: [ :each | each shouldBeDisplayed ] ]
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> displayText [
	^ UITheme current 
		newTextIn: World
		text: (self containerTree glamourPresentation formatedDisplayValueOf: self item) 
]

{ #category : #callbacks }
GLMTreeMorphNodeModel >> elementColumn [
	| row tags tagsFilter |
	row := OrderedCollection with: self displayText.
	tags:= self containerTree glamourPresentation tagsFor: self item to: #show.
	tagsFilter := self containerTree glamourPresentation tagsFor: self item to: #filter.
	tags withIndexDo:[ :each :index | 
			row addLast: (self buttonForTag: each 
									  filter: (tagsFilter at: index ifAbsentPut:[ each ])) ].
	^ UITheme current newRowIn: World for: row
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
"	self openItemPath: anArray"
	self containerTree changed: {#roots. #openItemPath}, (self path collect: [:each | each item]).
]

{ #category : #accessing }
GLMTreeMorphNodeModel >> icon [
	^ self containerTree glamourPresentation iconFor: self item
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
	"returns the list of nodes to the root"
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
GLMTreeMorphNodeModel >> rowMorphForColumn: aGlamourColumn [
	^ (UITheme current
		newTextIn: World
		text: (self containerTree glamourPresentation column: aGlamourColumn valueFor: self item)) unlock; wrapFlag: true; yourself
]

{ #category : #testing }
GLMTreeMorphNodeModel >> shouldBeDisplayed [
	^ self shouldBeDisplayedByTags and: [ self shouldBeDisplayedByText ]
]

{ #category : #testing }
GLMTreeMorphNodeModel >> shouldBeDisplayedByTags [
	| nodeTags |
	self flag: 'it looks like this method does not really get called for children'.
"	self item mooseName = #'org::easymock' ifTrue: [self haltOnce ].
"	self containerTree tagsToFilterBy isEmpty ifTrue: [ ^ true ].
	self withContentsDo: [ :node | 
		nodeTags := self containerTree glamourPresentation tagsFor: node item to: #filter.
		(self containerTree tagsToFilterBy allSatisfy: [ :each | nodeTags includes: each ])
			ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #testing }
GLMTreeMorphNodeModel >> shouldBeDisplayedByText [
	self containerTree shouldFilterByTextInput ifFalse: [ ^ true ].
	self withContentsDo: 
		[ :node | 
		self flag: 'this should be delegated to the presentation
		and glamourValue should be used to include the entity ports'.
		(self containerTree glamourPresentation filterStrategy 
			value: self containerTree inputText asString
			value: node item) == true ifTrue: [ ^ true ] ].
	^ false
]

{ #category : #callbacks }
GLMTreeMorphNodeModel >> tagsColumn [ 
	| tags |
	tags := (self containerTree glamourPresentation tagsFor: self item to: #show).
	tags isEmpty ifFalse: [
		^ self buttonForTag: tags last filter: tags last ].
	^ RectangleMorph new
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
