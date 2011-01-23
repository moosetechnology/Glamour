"
This is a specialization of the Announcer. The main added functionality is the ability to suspend the announcements from this announcer.
"
Class {
	#name : #GLMAnnouncer,
	#superclass : #Announcer,
	#instVars : [
		'suspendAll'
	],
	#category : #'Glamour-Helpers'
}

{ #category : #announce }
GLMAnnouncer >> announce: anAnnouncement [
	| announcement |
	announcement := anAnnouncement asAnnouncement.
	subscriptions ifNil: [ ^ announcement ].
	self suspendAll ifTrue: [ ^ announcement ].
	subscriptions keysAndValuesDo: [ :class :actions |
		(class handles: announcement) 
			ifTrue: [ actions valueWithArguments: (Array with: announcement) ] ].
	^ announcement
]

{ #category : #accessing }
GLMAnnouncer >> announcer [ 
	^ self
]

{ #category : #accessing }
GLMAnnouncer >> resetAnnouncer [
	self reset
]

{ #category : #suspending }
GLMAnnouncer >> suspendAll [
	^ suspendAll ifNil: [ suspendAll := false ].
]

{ #category : #suspending }
GLMAnnouncer >> suspendAllWhile: aBlock [
	| previousSuspensionState |
	previousSuspensionState := suspendAll.
	suspendAll := true.
	aBlock value.
	suspendAll := previousSuspensionState.
]
