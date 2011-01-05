Class {
	#name : #GLMExpanderLabelNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'containerTree'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'instance creation' }
GLMExpanderLabelNodeModel class >> with: anObject in: aTreeModel [
	^ (self with: anObject) containerTree: aTreeModel; yourself
]

{ #category : #accessing }
GLMExpanderLabelNodeModel >> containerTree [
	^ containerTree
]

{ #category : #accessing }
GLMExpanderLabelNodeModel >> containerTree: anObject [
	containerTree := anObject
]

{ #category : #accessing }
GLMExpanderLabelNodeModel >> displayText [
	^ UITheme current 
		newTextIn: World
		text: (self item presentations titleValue ifNil: ['noname']) 
]

{ #category : #callbacks }
GLMExpanderLabelNodeModel >> elementColumn [
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
GLMExpanderLabelNodeModel >> icon [
	^ nil
]

{ #category : #callbacks }
GLMExpanderLabelNodeModel >> rowMorphForColumn: aGlamourColumn [
	^ (UITheme current
		newTextIn: World
		text: (self item presentations titleValue)) unlock; wrapFlag: true; yourself
]
