Class {
	#name : #GLMTestAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'parameter'
	],
	#category : #'Glamour-Tests-Core'
}

{ #category : #'instance creation' }
GLMTestAnnouncement class >> with: aTestCase [
	^self new
		test: aTestCase;
		yourself
]

{ #category : #accessing }
GLMTestAnnouncement >> parameter [
	^ parameter
]

{ #category : #accessing }
GLMTestAnnouncement >> parameter: anObject [
	parameter := anObject
]

{ #category : #accessing }
GLMTestAnnouncement >> test [
	^test
]

{ #category : #accessing }
GLMTestAnnouncement >> test: aTest [
	test := aTest
]
