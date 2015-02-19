Class {
	#name : #GLMLiveStringBrick,
	#superclass : #GLMStringBrick,
	#instVars : [
		'textLogic'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #initialization }
GLMLiveStringBrick >> initialize [
	super initialize.
	textLogic := [ :x | x ]
]

{ #category : #'stepping and presenter' }
GLMLiveStringBrick >> step [

	self text: self textLogic value asString.
	self brickRoot doLayoutForce
]

{ #category : #accessing }
GLMLiveStringBrick >> textLogic [ 
	^ textLogic
]

{ #category : #accessing }
GLMLiveStringBrick >> textLogic: aBlock [
	textLogic := aBlock
]

{ #category : #testing }
GLMLiveStringBrick >> wantsSteps [
	^ true
]
