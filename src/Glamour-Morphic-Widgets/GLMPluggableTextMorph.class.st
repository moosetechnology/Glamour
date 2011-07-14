"
We subclass the default PluggableTextMorph just to raise the proper announcements when the text or when the selection changes.
"
Class {
	#name : #GLMPluggableTextMorph,
	#superclass : #PluggableTextMorph,
	#instVars : [
		'announcer'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'interactive error protocol' }
GLMPluggableTextMorph >> announceSelection: aString from: start to: stop [
	self announcer announce: (
		GLMSelectedTextChanged new 
			start: start; 
			end: stop;
			selectedText: aString )
]

{ #category : #'interactive error protocol' }
GLMPluggableTextMorph >> announceSelectionFrom: start to: stop [
	self announcer announce: (GLMSelectedTextChanged new start: start; end: stop)
]

{ #category : #accessing }
GLMPluggableTextMorph >> announcer [
	^ announcer ifNil: [announcer := GLMAnnouncer new]
]

{ #category : #'interactive error protocol' }
GLMPluggableTextMorph >> selectFrom: start to: stop [
	| result |
	result := super selectFrom: start to: stop.
	self announcer announce: (GLMSelectedTextChanged new start: start; end: stop).
	^ result
]

{ #category : #private }
GLMPluggableTextMorph >> textMorphClass [
	"this is needed for intercepting the shortcuts"
	^ GLMTextMorphForEditView
]