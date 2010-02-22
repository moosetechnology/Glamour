Class {
	#name : #TestAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'parameter'
	],
	#category : #'Glamour-Tests'
}

{ #category : #accessing }
TestAnnouncement >> parameter [
	^ parameter
]

{ #category : #accessing }
TestAnnouncement >> parameter: anObject [
	parameter := anObject
]
