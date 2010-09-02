"
We subclass the default PluggableShoutMorph just to raise the proper announcements when the text or when the selection changes.
"
Class {
	#name : #GLMPluggableShoutMorph,
	#superclass : #PluggableShoutMorph,
	#instVars : [
		'announcer'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMPluggableShoutMorph >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #'as yet unclassified' }
GLMPluggableShoutMorph >> selectFrom: start to: stop [
	| result |
	result := super selectFrom: start to: stop.
	self announcer announce: (GLMSelectedTextChanged new start: start; end: stop).
	^ result
]
