Class {
	#name : #GLMEventHandler,
	#superclass : #EventHandlerPlus,
	#instVars : [
		'announcer',
		'selectors'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #'as yet unclassified' }
GLMEventHandler class >> fromHandler: aHandler [
	|h|
	
	h := GLMEventHandler new.
	h copySameFrom: aHandler.
	^ h.
]

{ #category : #'as yet unclassified' }
GLMEventHandler >> announcer [
	"for subscriptions use:

	subscribeOn: selector send: recipientSelector to: recipient."
	
	^ announcer ifNil: [ announcer := Announcer new ].
]

{ #category : #'as yet unclassified' }
GLMEventHandler >> initialize [
	super initialize.
	
	selectors := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GLMEventHandler >> send: selector to: recipient withEvent: event fromMorph: sourceMorph [
	|announcement type|
	
	selector ifNotNil:
		[ super send: selector to: recipient withEvent: event fromMorph: sourceMorph ].
	
	type := event type.
	
	(selectors includes: type) ifTrue: [
		announcement := GLMEventHandlerAnnouncement new.
		announcement
			selector: type;
			recipient: recipient;
			event: event;
			sourceMorph: sourceMorph.
	
		self announcer announce: announcement.
	].
	
	
]

{ #category : #'as yet unclassified' }
GLMEventHandler >> subscribeOn:eventName send: recipientSelector to: recipient. [
	
	(selectors includes: eventName) ifFalse: [
			selectors add: eventName.
	].
	 
	self announcer weak
		on: GLMEventHandlerAnnouncement send: recipientSelector to: recipient.
]
