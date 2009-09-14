Class {
	#name : #GLMSTMethod,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'glmCategory'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMSTMethod >> glmCategory [
	^ glmCategory
]

{ #category : #accessing }
GLMSTMethod >> glmCategory: anObject [
	glmCategory := anObject
]

{ #category : #testing }
GLMSTMethod >> isMethod [
	^ true
]

{ #category : #accessing }
GLMSTMethod >> sourceCode [
	^ self glmCategory glmBehavior sourceCodeAt: self name
]
