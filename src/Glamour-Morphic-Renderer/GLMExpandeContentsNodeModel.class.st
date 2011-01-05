Class {
	#name : #GLMExpandeContentsNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'containerTree'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
GLMExpandeContentsNodeModel >> containerTree [
	^ containerTree
]

{ #category : #accessing }
GLMExpandeContentsNodeModel >> containerTree: anObject [
	containerTree := anObject
]

{ #category : #callbacks }
GLMExpandeContentsNodeModel >> elementColumn [
	| row tags tagsFilter |
	row := OrderedCollection with: ('ABC').
	^ UITheme current newRowIn: World for: row
]

{ #category : #accessing }
GLMExpandeContentsNodeModel >> icon [
	^ nil
]
