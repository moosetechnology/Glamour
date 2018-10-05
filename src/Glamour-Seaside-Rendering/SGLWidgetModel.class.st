Class {
	#name : #SGLWidgetModel,
	#superclass : #Object,
	#instVars : [
		'glamourPresentation',
		'announcer'
	],
	#category : #'Glamour-Seaside-Rendering'
}

{ #category : #accessing }
SGLWidgetModel >> announce: anAnnouncement [
	self announcer announce: anAnnouncement 
]

{ #category : #accessing }
SGLWidgetModel >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #accessing }
SGLWidgetModel >> glamourPresentation [
	^ glamourPresentation
]

{ #category : #accessing }
SGLWidgetModel >> glamourPresentation: anObject [
	glamourPresentation := anObject
]
