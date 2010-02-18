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

{ #category : #'as yet unclassified' }
GLMAnnouncer >> suspendAll [
	^ suspendAll ifNil: [ suspendAll := false ].
]

{ #category : #'as yet unclassified' }
GLMAnnouncer >> suspendAllWhile: aBlock [
	| previousSuspensionState |
	previousSuspensionState := suspendAll.
	suspendAll := true.
	aBlock value.
	suspendAll := previousSuspensionState.
]
