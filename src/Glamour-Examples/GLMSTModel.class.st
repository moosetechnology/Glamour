Class {
	#name : #GLMSTModel,
	#superclass : #Object,
	#instVars : [
		'environment'
	],
	#category : #'Glamour-Examples'
}

{ #category : #defaults }
GLMSTModel class >> defaultEnvironment [
	^ BrowserEnvironment new
]

{ #category : #accessing }
GLMSTModel >> = anObject [
	^ self class = anObject class and: [self name = anObject name ]
]

{ #category : #accessing }
GLMSTModel >> environment [
	^ environment ifNil: [environment := self class defaultEnvironment]
]

{ #category : #accessing }
GLMSTModel >> environment: anObject [
	environment := anObject
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
	self subclassResponsibility
]

{ #category : #printing }
GLMSTModel >> printOn: aStream [
	aStream nextPutAll: self name
]
