Class {
	#name : #GLMPagerButtonModel,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'isSelected',
		'isPressed',
		'isChecked',
		'data'
	],
	#category : #'Glamour-Morphic-Pager-Model'
}

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> check [
	self isChecked ifFalse: [
		isChecked := true.
		self announcer announce: (GLMPagerButtonChecked new).
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> click [
	self announcer announce: (GLMPagerButtonClicked new buttonModel: self).
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> data [

	^ data
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> data: anObject [

	data := anObject.
	"self announcer announce: (GLMPagerButtonDataChanged new)."
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> depress [
	self isPressed ifTrue: [ 
		isPressed := false.
		self announcer announce: (GLMPagerButtonDepressed new).
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> deselect [
	self isSelected ifTrue: [
		isSelected := false.
		self announcer announce: (GLMPagerButtonDeselected new).
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> initialize [
	super initialize.
	
	isSelected := false.
	isPressed := false.
	isChecked := false.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> isChecked [
	^ isChecked.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> isPressed [
	^ isPressed.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> isSelected [
	^ isSelected.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> on: anObject send: aSymbol to: aReceiver [
	self announcer weak
		on: anObject send: aSymbol to: aReceiver.
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> press [
	self isPressed ifFalse: [
		isPressed := true.
		self announcer announce: (GLMPagerButtonPressed new).
		self click.
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> select [
	self isSelected ifFalse: [ 
		isSelected := true.
		self announcer announce: (GLMPagerButtonSelected new buttonModel: self).
	]
]

{ #category : #'as yet unclassified' }
GLMPagerButtonModel >> uncheck [
	self isChecked ifTrue: [
		isChecked := false.
		self announcer announce: (GLMPagerButtonUnChecked new).
	]
]
