Class {
	#name : #GLMSTProtocol,
	#superclass : #GLMSTNamedModel,
	#instVars : [
		'glmBehavior'
	],
	#category : #'Glamour-Examples'
}

{ #category : #accessing }
GLMSTProtocol >> glmBehavior [
	^ glmBehavior
]

{ #category : #accessing }
GLMSTProtocol >> glmBehavior: anObject [ 
	glmBehavior := anObject
]

{ #category : #testing }
GLMSTProtocol >> isCategory [
	^ true
]

{ #category : #accessing }
GLMSTProtocol >> methods [
	^ (self glmBehavior stBehavior organization listAtCategoryNamed: self name) asSortedCollection collect: 
		[ :each | 
		GLMSTMethod new
			name: each;
			glmCategory: self;
			yourself ]
]
