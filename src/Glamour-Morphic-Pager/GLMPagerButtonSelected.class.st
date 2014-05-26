Class {
	#name : #GLMPagerButtonSelected,
	#superclass : #GLMPagerButtonAnnouncement,
	#instVars : [
		'buttonModel'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMPagerButtonSelected >> buttonModel [
	^ buttonModel
]

{ #category : #accessing }
GLMPagerButtonSelected >> buttonModel: anObject [
	buttonModel := anObject
]
