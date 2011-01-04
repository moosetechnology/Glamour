Class {
	#name : #GLMExpanderTreeMorphNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'containerTree'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'instance creation' }
GLMExpanderTreeMorphNodeModel class >> with: anObject in: aTreeModel [
	^ (self with: anObject) containerTree: aTreeModel; yourself
]

{ #category : #accessing }
GLMExpanderTreeMorphNodeModel >> containerTree [
	^ containerTree
]

{ #category : #accessing }
GLMExpanderTreeMorphNodeModel >> containerTree: anObject [
	containerTree := anObject
]

{ #category : #accessing }
GLMExpanderTreeMorphNodeModel >> displayText [
	^ UITheme current 
		newTextIn: World
		text: (self item presentations titleValue ifNil: ['noname']) 
]

{ #category : #callbacks }
GLMExpanderTreeMorphNodeModel >> elementColumn [
	| row tags tagsFilter |
	row := OrderedCollection with: (self displayText).
"	tags:= self containerTree glamourPresentation tagsFor: self item to: #show.
	tagsFilter := self containerTree glamourPresentation tagsFor: self item to: #filter.
	tags withIndexDo:[ :each :index | 
			row addLast: (self buttonForTag: each 
									  filter: (tagsFilter at: index ifAbsentPut:[ each ])) ].
"	^ UITheme current newRowIn: World for: row
]

{ #category : #accessing }
GLMExpanderTreeMorphNodeModel >> icon [
	^ nil
]

{ #category : #callbacks }
GLMExpanderTreeMorphNodeModel >> rowMorphForColumn: aGlamourColumn [
	^ (UITheme current
		newTextIn: World
		text: (self item presentations titleValue)) unlock; wrapFlag: true; yourself
]
