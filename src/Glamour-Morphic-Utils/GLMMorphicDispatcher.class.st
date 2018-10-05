Class {
	#name : #GLMMorphicDispatcher,
	#superclass : #KMDispatcher,
	#category : #'Glamour-Morphic-Utils'
}

{ #category : #'as yet unclassified' }
GLMMorphicDispatcher >> categories [
	"need to return a non-empty collection here in order to enter the keymapper!"
	^ Array with: #all.
]

{ #category : #'as yet unclassified' }
GLMMorphicDispatcher >> matchEvent: event [
	event commandKeyPressed ifFalse: [ ^ self ].
	Transcript show: self target realTarget text.
	event wasHandled: true.
]
