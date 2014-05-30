Class {
	#name : #GLMPagerScrolled,
	#superclass : #Announcement,
	#instVars : [
		'value',
		'smooth'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMPagerScrolled >> smooth [
	^ smooth
]

{ #category : #accessing }
GLMPagerScrolled >> smooth: anObject [
	smooth := anObject
]

{ #category : #accessing }
GLMPagerScrolled >> value [
	^ value
]

{ #category : #accessing }
GLMPagerScrolled >> value: anObject [
	value := anObject
]
