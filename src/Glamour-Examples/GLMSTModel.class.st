Class {
	#name : #GLMSTModel,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'as yet unclassified' }
GLMSTModel class >> named: aString [
	^ self new
		name: aString;
		yourself
]

{ #category : #testing }
GLMSTModel >> isCategory [
	^ false
]

{ #category : #testing }
GLMSTModel >> isClass [
	^ false
]

{ #category : #testing }
GLMSTModel >> isClassCategory [
	^ false
]

{ #category : #testing }
GLMSTModel >> isMethod [
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
