Class {
	#name : #GLMAnnouncerTest,
	#superclass : #TestCase,
	#instVars : [
		'announcer'
	],
	#category : #'Glamour-Tests-Core'
}

{ #category : #running }
GLMAnnouncerTest >> setUp [
	announcer := GLMAnnouncer new
]

{ #category : #tests }
GLMAnnouncerTest >> testNestedSuspendAllWhile [
	| announcement |
	announcer
		subscribe: TestAnnouncement
		do: [ :ann | announcement := ann ].
	
	announcement := nil.
	announcer suspendAllWhile: [
		announcer suspendAllWhile: [ ].
		announcer announce: TestAnnouncement ].
	self assert: announcement isNil
]

{ #category : #tests }
GLMAnnouncerTest >> testSuspendAllWhile [
	| announcement instance |
	announcer
		subscribe: TestAnnouncement
		do: [ :ann | announcement := ann ].
		
	announcement := nil.
	instance := announcer announce: TestAnnouncement.
	self assert: announcement = instance.
	
	announcement := nil.
	announcer suspendAllWhile: [
		instance := announcer announce: TestAnnouncement ].
	self assert: announcement isNil
]
