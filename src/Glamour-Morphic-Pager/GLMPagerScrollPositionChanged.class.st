Class {
	#name : #GLMPagerScrollPositionChanged,
	#superclass : #Announcement,
	#instVars : [
		'smooth'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMPagerScrollPositionChanged >> smooth [
	^ smooth
]

{ #category : #accessing }
GLMPagerScrollPositionChanged >> smooth: anObject [
	smooth := anObject
]
