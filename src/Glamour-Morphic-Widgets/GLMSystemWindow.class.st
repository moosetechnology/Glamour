"
This is the window in which the Glamour browsers are rendered in Morphic.
"
Class {
	#name : #GLMSystemWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'toolbarBox'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #announcement }
GLMSystemWindow >> allKeystrokeActions [
	^ self model notNil 
		ifTrue: [
			(self model allActions, self model allSelectionActions) select: [ :action | 
				action hasShortcut ]]
		ifFalse: [#()]
]

{ #category : #building }
GLMSystemWindow >> buildWindowMenu [
	| actions aMenu |
	actions := self model allActions select: [:each | each hasTitle and: [each hasIcon not]].
	^ actions isEmpty
		ifTrue: [ super buildWindowMenu ]
		ifFalse: [
			aMenu := self theme newMenuIn: self for: self.
			actions
				inject: aMenu
				into: [ :menu :action |
					menu
						add: action title target: action selector: #actOn: argument: self model;
						yourself ] ]
]

{ #category : #'open/close' }
GLMSystemWindow >> delete [
	self model notNil ifTrue: [self model unregisterFromAllAnnouncements].
	super delete
]

{ #category : #building }
GLMSystemWindow >> extent: aPoint [ 
	super extent: aPoint.
	self fullBounds
]

{ #category : #'event handling' }
GLMSystemWindow >> handleKeyStroke: anEvent [
	| action |
	action := self allKeystrokeActions detect: [:a | 
		anEvent commandKeyPressed and: [ 
			a shortcut = anEvent keyCharacter ]] ifNone: [nil].
	action ifNotNil: [ self announcer announce: (GLMKeyStroke action: action) ]
]

{ #category : #accessing }
GLMSystemWindow >> toolbarBox: anObject [
	toolbarBox := anObject.
	self replacePane: menuBox with: toolbarBox
]

{ #category : #announcement }
GLMSystemWindow >> when: anAnnouncement do: aBlock [ 
	^ self announcer when: anAnnouncement do: aBlock
]
