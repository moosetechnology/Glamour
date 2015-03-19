Class {
	#name : #GLMEditableLabelBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'labelBrick',
		'editBrick'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-UI'
}

{ #category : #'as yet unclassified' }
GLMEditableLabelBrick >> hShrinkWrap [
	super hShrinkWrap.
	
	self labelBrick hShrinkWrap
]

{ #category : #'as yet unclassified' }
GLMEditableLabelBrick >> hSpaceFill [
	super hSpaceFill.
	
	self label hSpaceFill
]

{ #category : #'as yet unclassified' }
GLMEditableLabelBrick >> labelBrick [

	^ labelBrick
]

{ #category : #'as yet unclassified' }
GLMEditableLabelBrick >> labelBrick: aBrick [

	labelBrick := aBrick.
	
	self addBrickBack: labelBrick
	
]

{ #category : #'as yet unclassified' }
GLMEditableLabelBrick >> vShrinkWrap [
	super vShrinkWrap.
	
	self label vShrinkWrap
]
