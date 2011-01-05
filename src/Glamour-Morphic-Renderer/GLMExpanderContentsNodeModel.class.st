Class {
	#name : #GLMExpanderContentsNodeModel,
	#superclass : #MorphTreeNodeModel,
	#instVars : [
		'containerNode'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
GLMExpanderContentsNodeModel >> containerNode [
	^ containerNode
]

{ #category : #accessing }
GLMExpanderContentsNodeModel >> containerNode: anObject [
	containerNode := anObject
]

{ #category : #callbacks }
GLMExpanderContentsNodeModel >> elementColumn [
	| row tags tagsFilter |
	
	row := OrderedCollection with: (GLMMorphicRenderer new render: self containerNode item).
	^ UITheme current newRowIn: World for: row
]

{ #category : #accessing }
GLMExpanderContentsNodeModel >> icon [
	^ nil
]
