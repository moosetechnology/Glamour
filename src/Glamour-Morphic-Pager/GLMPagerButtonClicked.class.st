Class {
	#name : #GLMPagerButtonClicked,
	#superclass : #GLMPagerButtonAnnouncement,
	#instVars : [
		'buttonModel'
	],
	#category : #'Glamour-Morphic-Pager-Announcement'
}

{ #category : #accessing }
GLMPagerButtonClicked >> buttonModel [
	^ buttonModel
]

{ #category : #accessing }
GLMPagerButtonClicked >> buttonModel: anObject [
	buttonModel := anObject
]
