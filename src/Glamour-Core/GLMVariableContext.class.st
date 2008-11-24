Class {
	#name : #GLMVariableContext,
	#superclass : #GLMContext,
	#instVars : [
		'contextMap'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMVariableContext >> asDisplayObject [
	^ self currentContext asDisplayObject
]

{ #category : #'as yet unclassified' }
GLMVariableContext >> contextMap [

	^ contextMap ifNil: [contextMap := OrderedCollection new]
]

{ #category : #'as yet unclassified' }
GLMVariableContext >> currentContext [

	| context |
	context := (self contextMap detect: [:each | each key value: self entity]) value.
	^ context copy entity: self entity; yourself
]

{ #category : #'as yet unclassified' }
GLMVariableContext >> on: aConditionBlock put: aContext [

	^ self contextMap addFirst: aConditionBlock -> aContext
]
