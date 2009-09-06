Class {
	#name : #GLMSTBehavior,
	#superclass : #GLMSTModel,
	#instVars : [
		'stBehavior'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMSTBehavior >> categories [
	^ self stBehavior organization categories collect: [:each |
		GLMSTCategory new name: each; glmClass: self; yourself]
]

{ #category : #accessing }
GLMSTBehavior >> comment [
	^ self stBehavior comment
]

{ #category : #accessing }
GLMSTBehavior >> definition [
	^ self stBehavior definition
]

{ #category : #accessing }
GLMSTBehavior >> name [
	^ self stBehavior name
]

{ #category : #accessing }
GLMSTBehavior >> sourceCodeAt: aSelector [
	^ self stBehavior sourceCodeAt: aSelector
]

{ #category : #accessing }
GLMSTBehavior >> stBehavior [
	^ stBehavior
]

{ #category : #accessing }
GLMSTBehavior >> stBehavior: anObject [
	stBehavior := anObject
]

{ #category : #accessing }
GLMSTBehavior >> traits [
	^ self stBehavior traitComposition traits collect: [:each |
		GLMSTTrait new stBehavior: each; yourself]
]
