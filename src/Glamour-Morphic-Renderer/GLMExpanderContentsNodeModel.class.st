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
	| row morph |
	
	morph := GLMMorphicWidgetRenderer new	renderPaneWithoutTitle: self containerNode item.
	morph 
		borderStyle: (UITheme current buttonSelectedBorderStyleFor: morph).

	row := OrderedCollection with: morph.
	^ UITheme current newRowIn: World for: row
]

{ #category : #accessing }
GLMExpanderContentsNodeModel >> icon [
	^ nil
]
