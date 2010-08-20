Class {
	#name : #SGLModel,
	#superclass : #Object,
	#instVars : [
		'glamourPresentation',
		'announcer'
	],
	#category : #'Glamour-Seaside-Core'
}

{ #category : #accessing }
SGLModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #accessing }
SGLModel >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #accessing }
SGLModel >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
SGLModel >> glamourPresentation: anObject [
	glamourPresentation := anObject
]
