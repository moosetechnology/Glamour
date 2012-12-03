Class {
	#name : #TestAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'parameter'
	],
	#category : #'Glamour-Tests-Core'
}

{ #category : #'instance creation' }
TestAnnouncement class >> with: aTestCase [
	^self new
		test: aTestCase;
		yourself
]

{ #category : #accessing }
TestAnnouncement >> parameter [
	^ parameter
]

{ #category : #accessing }
TestAnnouncement >> parameter: anObject [
	parameter := anObject
]

{ #category : #accessing }
TestAnnouncement >> test [
	^test
]

{ #category : #accessing }
TestAnnouncement >> test: aTest [
	test := aTest
]
