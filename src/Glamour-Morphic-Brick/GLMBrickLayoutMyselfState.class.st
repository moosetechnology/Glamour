Class {
	#name : #GLMBrickLayoutMyselfState,
	#superclass : #GLMBrickLayoutState,
	#instVars : [
		'dimension'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #initialization }
GLMBrickLayoutMyselfState >> defaultDimension [

	^ 50
]

{ #category : #accessing }
GLMBrickLayoutMyselfState >> dimension [
	^ dimension
]

{ #category : #accessing }
GLMBrickLayoutMyselfState >> dimension: anObject [
	dimension := anObject
]

{ #category : #initialization }
GLMBrickLayoutMyselfState >> initialize [
	super initialize.
	
	dimension := self defaultDimension
]

{ #category : #testing }
GLMBrickLayoutMyselfState >> isOnMyself [

	^ true
]
