Class {
	#name : #GLMCompositeCompletionRequest,
	#superclass : #Notification,
	#instVars : [
		'requests',
		'prompt',
		'default'
	],
	#category : #'Glamour-Morphic-Renderer-Spotter'
}

{ #category : #'initialize-release' }
GLMCompositeCompletionRequest >> add: aRequest [
	requests add: aRequest 
]

{ #category : #accessing }
GLMCompositeCompletionRequest >> default [
	^ default
]

{ #category : #accessing }
GLMCompositeCompletionRequest >> default: anObject [
	default := anObject
]

{ #category : #'initialize-release' }
GLMCompositeCompletionRequest >> defaultAction [
	^(GLMMorphicSpotlight openOn: self) answer
]

{ #category : #'initialize-release' }
GLMCompositeCompletionRequest >> handleWith: anObject [
	^ anObject handleCompletionRequest: self
]

{ #category : #'initialize-release' }
GLMCompositeCompletionRequest >> initialize [
	super initialize.
	requests := OrderedCollection new.
]

{ #category : #accessing }
GLMCompositeCompletionRequest >> prompt [
	^ prompt
]

{ #category : #accessing }
GLMCompositeCompletionRequest >> prompt: anObject [
	prompt := anObject
]

{ #category : #accessing }
GLMCompositeCompletionRequest >> requests [
	^requests 
]
