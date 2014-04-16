Class {
	#name : #GLMPageSwitched,
	#superclass : #Announcement,
	#instVars : [
		'smooth'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMPageSwitched >> smooth [
	^ smooth
]

{ #category : #accessing }
GLMPageSwitched >> smooth: anObject [
	smooth := anObject
]
