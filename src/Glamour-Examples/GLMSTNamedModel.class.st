Class {
	#name : #GLMSTNamedModel,
	#superclass : #GLMSTModel,
	#instVars : [
		'name'
	],
	#category : #'Glamour-Examples'
}

{ #category : #'instance creation' }
GLMSTNamedModel class >> named: aString [
	^ self named: aString environment: self defaultEnvironment
]

{ #category : #'instance creation' }
GLMSTNamedModel class >> named: aString environment: anEnvironment [
	^ self new
		name: aString;
		environment: anEnvironment;
		yourself
]

{ #category : #accessing }
GLMSTNamedModel >> name [
	^ name
]

{ #category : #accessing }
GLMSTNamedModel >> name: anObject [
	name := anObject
]
