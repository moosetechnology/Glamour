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

{ #category : #callbacks }
GLMSystemWindow >> actOnWindowRequest: ann [

	ann action value: self	
]

{ #category : #announcement }
GLMSystemWindow >> allKeystrokeActions [
	^ self model notNil 
		ifTrue: [
			(self model allActions, self model allSelectionActions) select: [ :action | 
				action hasShortcut ]]
		ifFalse: [#()]
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

{ #category : #'as yet unclassified' }
GLMSystemWindow >> handleKeyStroke: anEvent [
	| action |
	action := self allKeystrokeActions detect: [:a | 
		anEvent commandKeyPressed and: [ 
			a shortcut = anEvent keyCharacter ]] ifNone: [nil].
	action ifNotNil: [ self announcer announce: (GLMKeyStroke action: action) ]
]

{ #category : #initialization }
GLMSystemWindow >> initialize [ 
	super initialize.
	self
		on: #keyStroke 
		send: #handleKeyStroke: 
		to: self	
]

{ #category : #accessing }
GLMSystemWindow >> setLabelWidgetAllowance [
	^ labelWidgetAllowance :=  super setLabelWidgetAllowance +
		(toolbarBox
			ifNil: [ 0 ]
			ifNotNil: [ :toolbar | toolbarBox width ])
]

{ #category : #accessing }
GLMSystemWindow >> toolbarBox: anObject [

	toolbarBox := anObject.
	self setLabelWidgetAllowance.
	self replacePane: menuBox with: toolbarBox
]

{ #category : #announcement }
GLMSystemWindow >> when: anAnnouncement do: aBlock [ 
	^ self announcer when: anAnnouncement do: aBlock
]
