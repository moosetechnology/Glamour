Class {
	#name : #LazyTabPageAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'page',
		'tabs'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
LazyTabPageAnnouncement >> page [
	^ page
]

{ #category : #accessing }
LazyTabPageAnnouncement >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LazyTabPageAnnouncement >> tabs [
	^ tabs
]

{ #category : #accessing }
LazyTabPageAnnouncement >> tabs: anObject [
	tabs := anObject
]
