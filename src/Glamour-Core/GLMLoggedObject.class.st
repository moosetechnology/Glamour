Class {
	#name : #GLMLoggedObject,
	#superclass : #GLMAnnouncer,
	#instVars : [
		'logger'
	],
	#classInstVars : [
		'logger'
	],
	#category : #'Glamour-Core'
}

{ #category : #'as yet unclassified' }
GLMLoggedObject class >> initialize [ 
	logger := GLMLogger instance
]

{ #category : #'as yet unclassified' }
GLMLoggedObject class >> logger [
	^ logger
]

{ #category : #'as yet unclassified' }
GLMLoggedObject class >> logger: aLogger [
	logger := aLogger
]

{ #category : #announce }
GLMLoggedObject >> announce: anAnnouncement [
	self logger logAnnouncement: anAnnouncement from: self. 
	super announce: anAnnouncement
]

{ #category : #'initialize-release' }
GLMLoggedObject >> initialize [ 
	super initialize.
	logger := GLMLogger instance 
]

{ #category : #accessing }
GLMLoggedObject >> logger [
	^ logger
]

{ #category : #accessing }
GLMLoggedObject >> logger: anObject [
	logger := anObject
]
