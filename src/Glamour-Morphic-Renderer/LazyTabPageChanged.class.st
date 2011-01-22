Class {
	#name : #LazyTabPageChanged,
	#superclass : #LazyTabPageAnnouncement,
	#instVars : [
		'oldPage'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #accessing }
LazyTabPageChanged >> oldPage [
	^ oldPage
]

{ #category : #accessing }
LazyTabPageChanged >> oldPage: anObject [
	oldPage := anObject
]
