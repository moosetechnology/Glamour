Class {
	#name : #GLMBrickLayoutParentState,
	#superclass : #GLMBrickLayoutState,
	#instVars : [
		'percent'
	],
	#category : #'Glamour-Morphic-Brick-Layouts'
}

{ #category : #initialization }
GLMBrickLayoutParentState >> defaultPercent [

	^ 100
]

{ #category : #initialization }
GLMBrickLayoutParentState >> initialize [
	super initialize.
	
	percent := self defaultPercent
]

{ #category : #testing }
GLMBrickLayoutParentState >> isOnParent [
	^ true
]

{ #category : #accessing }
GLMBrickLayoutParentState >> percent [
	^ percent
]

{ #category : #accessing }
GLMBrickLayoutParentState >> percent: anObject [
	percent := anObject
]
