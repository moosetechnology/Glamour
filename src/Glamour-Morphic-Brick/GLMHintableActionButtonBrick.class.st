Class {
	#name : #GLMHintableActionButtonBrick,
	#superclass : #GLMActionButtonBrick,
	#instVars : [
		'hintTitle',
		'hintText',
		'hintDelay',
		'hintModifier'
	],
	#classInstVars : [
		'asyncTask'
	],
	#category : #'Glamour-Morphic-Brick-Widgets-Core'
}

{ #category : #converting }
GLMHintableActionButtonBrick class >> asyncTaskUniqueInstance [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #actions }
GLMHintableActionButtonBrick >> click: evt [
	|result|
	result := super click: evt.
	self class asyncTaskUniqueInstance terminate.
	^ result
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintDelay [

	^ hintDelay ifNil: [ hintDelay := 700 ]
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintDelay: anObject [
	hintDelay := anObject
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintModifier [

	^ hintModifier ifNil: [ hintModifier := #shift ]
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintModifier: anObject [

	hintModifier := anObject
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintText [

	^ hintText ifNil: [ hintText := 'Need help?' ]
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintText: anObject [

	hintText := anObject
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintTitle [

	^ hintTitle ifNil: [ hintTitle := 'Hi,' ]
]

{ #category : #accessing }
GLMHintableActionButtonBrick >> hintTitle: anObject [
	hintTitle := anObject
]

{ #category : #initialization }
GLMHintableActionButtonBrick >> initialize [
	super initialize.
	
	self addHoverAction: [ :b :evt |
		self class asyncTaskUniqueInstance
			perform: [ self isInWorld ifTrue: [ GLMPopupBrick new titleText: self hintTitle; hintText: self hintText; beHelp; openFor: self ] ]
			delay: ((self isModifierPressed: evt) ifTrue: [ 0 ] ifFalse: [ self hintDelay ]) ].
]

{ #category : #'as yet unclassified' }
GLMHintableActionButtonBrick >> isModifierPressed: anEvent [

	self hintModifier ifNil: [ ^ false ].
	self hintModifier = #shift ifTrue: [ ^ anEvent shiftPressed ].
	self hintModifier = #option ifTrue: [ ^ anEvent optionKeyPressed ].
	self hintModifier = #alt ifTrue: [ ^ anEvent altKeyPressed ].
	self hintModifier = #command ifTrue: [ ^ anEvent commandKeyPressed ].
	self hintModifier = #control ifTrue: [ ^ anEvent controlKeyPressed ].
	^ false
]
