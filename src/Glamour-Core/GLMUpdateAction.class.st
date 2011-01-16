"
GLMUpdateAction is used for controlling the updating of a presentation when an announcement. is sent by the announcerObjects.

Instance Variables:
	condition	<Boolean>
	presentation	<GLMPresentation>
	announcement	<Announcement>
	announcerObjects	<(Collection of: Objects)>
	transformation	<BlockClosure>
"
Class {
	#name : #GLMUpdateAction,
	#superclass : #Object,
	#instVars : [
		'condition',
		'presentation',
		'announcement',
		'announcerObjects',
		'transformation',
		'id'
	],
	#category : #'Glamour-Core'
}

{ #category : #'hack-for-announcements' }
GLMUpdateAction >> = other [ 
	self flag: 'see http://code.google.com/p/moose-technology/issues/detail?id=492'.
	self species = other species ifFalse: [ ^false ].
	^self id = other id
]

{ #category : #accessing }
GLMUpdateAction >> announcement [
	^ announcement
]

{ #category : #accessing }
GLMUpdateAction >> announcement: anObject [
	announcement := anObject
]

{ #category : #accessing }
GLMUpdateAction >> announcerObjects [ 
	^ announcerObjects := self computeAnnouncerObjects ifNil: [OrderedCollection new]
]

{ #category : #public }
GLMUpdateAction >> computeAnnouncerObjects [ 
	self subclassResponsibility
]

{ #category : #accessing }
GLMUpdateAction >> condition [
	^ condition
]

{ #category : #accessing }
GLMUpdateAction >> condition: anObject [
	condition := anObject
]

{ #category : #'hack-for-announcements' }
GLMUpdateAction >> hash [ 
	self flag: 'see http://code.google.com/p/moose-technology/issues/detail?id=492'.
	^self species hash bitXor: self id hash
]

{ #category : #'hack-for-announcements' }
GLMUpdateAction >> id [ 
	self flag: 'see http://code.google.com/p/moose-technology/issues/detail?id=492'.
	^id ifNil: [ id = UUID new asString ]
]

{ #category : #'initialize-release' }
GLMUpdateAction >> initialize [
	super initialize.
	condition := true
]

{ #category : #copying }
GLMUpdateAction >> postCopy [
	super postCopy.
	announcerObjects := nil
]

{ #category : #accessing }
GLMUpdateAction >> presentation [
	^ presentation
]

{ #category : #accessing }
GLMUpdateAction >> presentation: anObject [
	presentation := anObject
]

{ #category : #public }
GLMUpdateAction >> registerInPresentation [
	self announcerObjects do: [: announcerObject |
		announcerObject notNil ifTrue: [
			announcerObject on: self announcement do: [ :ann | 
			| allowedToTrigger |
			allowedToTrigger := self condition glamourValue: (ann asGlamorousMultiValue, self presentation entity asGlamorousMultiValue).
			allowedToTrigger ifTrue: [ self presentation update ] ].
			"we remember the announcer object to be able to 
			unregister from it when the presentation goes away"
			self presentation registeredAnnouncers add: announcerObject ] ]
]

{ #category : #accessing }
GLMUpdateAction >> transformation [
	^ transformation
]

{ #category : #accessing }
GLMUpdateAction >> transformation: anObject [
	transformation := anObject
]

{ #category : #public }
GLMUpdateAction >> unregisterFromAllAnnouncements [
	self flag: 'We use the equality unsubscription mechanism because of deep copying in Glamour'.
	self flag: 'Old implementation:
	[self announcerObjects do: [:each | 
		each unsubscribe: self ]] on: Error do: [:e | ]'.
	self announcerObjects 
		do: [:each | each unsubscribeNonIdentical: self ]
]
