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
		'action',
		'hoverAction'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #accessing }
GLMActionButtonBrick >> action: anAction [

	action := anAction.
	
	self normalImage: action icon.
	self pressedColor: Color veryVeryLightGray
]

{ #category : #adding }
GLMActionButtonBrick >> addHoverAction: anObject [

	hoverAction := anObject
]

{ #category : #adding }
GLMActionButtonBrick >> addUpAction: anActionOrBlock [

	anActionOrBlock isBlock
		ifTrue: [ action := anActionOrBlock ]
		ifFalse: [ self action: anActionOrBlock ]
]

{ #category : #actions }
GLMActionButtonBrick >> click: evt [
	
	action ifNil: [ ^ false ].
	action isBlock
		ifTrue: [ action cull: self cull: evt ]
		ifFalse: [ action performOn: self data ].
	
	^ true
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
	
	self enable.
]

{ #category : #actions }
GLMActionButtonBrick >> select: anEvent [
	super select: anEvent.
	
	hoverAction ifNotNil: [ :a | a cull: self cull: anEvent ]
]
