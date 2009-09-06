Class {
	#name : #GLMSTModel,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Glamour-Examples'
}

{ #category : #testing }
GLMSTModel >> isCategory [
	^ false
]

{ #category : #accessing }
GLMSTModel >> name [
	^ name
]

{ #category : #accessing }
GLMSTModel >> name: anObject [
	name := anObject
]

{ #category : #printing }
GLMSTModel >> printOn: aStream [
	aStream nextPutAll: self name
]
