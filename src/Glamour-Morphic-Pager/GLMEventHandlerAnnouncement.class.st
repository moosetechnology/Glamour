Class {
	#name : #GLMEventHandlerAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'selector',
		'recipient',
		'event',
		'sourceMorph'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMEventHandlerAnnouncement >> event [
	^ event
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> event: anObject [
	event := anObject
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> recipient [
	^ recipient
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> recipient: anObject [
	recipient := anObject
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> selector [
	^ selector
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> sourceMorph [
	^ sourceMorph
]

{ #category : #accessing }
GLMEventHandlerAnnouncement >> sourceMorph: anObject [
	sourceMorph := anObject
]
