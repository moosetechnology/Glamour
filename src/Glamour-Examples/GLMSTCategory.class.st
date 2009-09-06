Class {
	#name : #GLMSTCategory,
	#superclass : #GLMSTModel,
	#instVars : [
		'glmClass'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMSTCategory >> glmClass [
	^ glmClass
]

{ #category : #accessing }
GLMSTCategory >> glmClass: anObject [
	glmClass := anObject
]

{ #category : #testing }
GLMSTCategory >> isCategory [
	^ true
]

{ #category : #accessing }
GLMSTCategory >> methods [
	^ (self glmClass stBehavior organization listAtCategoryNamed: self name) asSortedCollection collect: [:each |
		GLMSTMethod new name: each; glmCategory: self; yourself ]
]

{ #category : #accessing }
GLMSTCategory >> name [
	^ name
]

{ #category : #accessing }
GLMSTCategory >> name: anObject [
	name := anObject
]
