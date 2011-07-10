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
	self suspendAll ifTrue: [ ^ anAnnouncement asAnnouncement ].
	^ super announce: anAnnouncement
]

{ #category : #accessing }
GLMAnnouncer >> announcer [ 
	^ self
]

{ #category : #accessing }
GLMAnnouncer >> glmSubscriptions [
	^ registry glmSubscriptions
]

{ #category : #accessing }
GLMAnnouncer >> resetAnnouncer [
	registry reset
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
