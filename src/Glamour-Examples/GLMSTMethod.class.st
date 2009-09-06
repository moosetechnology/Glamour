Class {
	#name : #GLMSTMethod,
	#superclass : #GLMSTModel,
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
	^ self glmCategory glmClass sourceCodeAt: self name
]
