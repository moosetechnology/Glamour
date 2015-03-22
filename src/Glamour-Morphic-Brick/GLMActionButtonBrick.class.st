"
A GLMActionButtonBrick is a button for Glamour actions, used in Tabbed presentations

Instance Variables
	action:		<Object>

action
	- xxxxx

"
Class {
	#name : #GLMActionButtonBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'hoverAction',
		'unhoverAction',
		'clickAction'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #actions }
GLMActionButtonBrick >> action: anObject [

	clickAction := anObject
]

{ #category : #'brick-interactable-actions' }
GLMActionButtonBrick >> click: anEvent [
	
	clickAction ifNil: [ ^ false ].
	clickAction brickValue: self withEnoughArguments: { anEvent }.
	
	^ true
]

{ #category : #'brick-interactable-actions' }
GLMActionButtonBrick >> deselect: anEvent [
	super deselect: anEvent.
	
	unhoverAction ifNotNil: [ :a | a brickValue: self withEnoughArguments: { anEvent } ]
]

{ #category : #actions }
GLMActionButtonBrick >> hoverAction: anObject [

	hoverAction := anObject
]

{ #category : #accessing }
GLMActionButtonBrick >> icon [

	^ self normalImage
]

{ #category : #accessing }
GLMActionButtonBrick >> icon: anImage [

	self normalImage: anImage.
]

{ #category : #initialization }
GLMActionButtonBrick >> initialize [
	super initialize.
	
	self enable
]

{ #category : #'brick-interactable-actions' }
GLMActionButtonBrick >> select: anEvent [
	super select: anEvent.
	
	hoverAction ifNotNil: [ :a | a brickValue: self withEnoughArguments: { anEvent } ]
]

{ #category : #actions }
GLMActionButtonBrick >> unhoverAction: anObject [

	unhoverAction := anObject
]
