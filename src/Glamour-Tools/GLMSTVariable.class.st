Class {
	#name : #GLMSTVariable,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'glmBehavior'
	],
	#category : #'Glamour-Tools'
}

{ #category : #accessing }
GLMSTVariable >> accessingMethods [
	| selectors |
	selectors := self glmBehavior stBehavior whichSelectorsAccess: self name.
	^ self glmBehavior methods select: [:each | selectors includes: each name ]
]

{ #category : #accessing }
GLMSTVariable >> glmBehavior [
	^ glmBehavior
]

{ #category : #accessing }
GLMSTVariable >> glmBehavior: anObject [
	glmBehavior := anObject
]
