Class {
	#name : #GLMRubricTextFieldArea,
	#superclass : #RubEditingArea,
	#instVars : [
		'enabled',
		'doubleClickAction'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'event handling' }
GLMRubricTextFieldArea >> click [
	"empty"
]

{ #category : #defaults }
GLMRubricTextFieldArea >> defaultMargins [
	^ 1 @ 1 corner: 10 @ 1
]

{ #category : #protocol }
GLMRubricTextFieldArea >> disable [

	self isEnabled ifFalse: [ ^ self ].
	
	enabled := false.
	self editingMode: RubPlainTextMode new.
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> doubleClick: anEvent [

	self isEnabled ifTrue: [ ^ self ].
	
	self isEnabled ifFalse: [
		self doubleClickAction ifNotNil: [ :aBlock | aBlock value ].
		self enable.
		super mouseDown: anEvent ]
]

{ #category : #accessing }
GLMRubricTextFieldArea >> doubleClickAction [

	^ doubleClickAction
]

{ #category : #accessing }
GLMRubricTextFieldArea >> doubleClickAction: aBlock [

	doubleClickAction := aBlock
]

{ #category : #protocol }
GLMRubricTextFieldArea >> enable [

	self isEnabled ifTrue: [ ^ self ].
	
	enabled := true.
	self editingMode: RubSmalltalkCodeMode new.
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> focusChanged [
	super focusChanged.
	
	self hasFocus ifFalse: [
		self disable.
	].
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> handlesMouseOver: evt [

	^ self isEnabled
]

{ #category : #initialize }
GLMRubricTextFieldArea >> initialize [
	super initialize.
	
	enabled := false.
	self backgroundColor: Color transparent.
]

{ #category : #testing }
GLMRubricTextFieldArea >> isEnabled [

	^ enabled
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> keyStroke: evt [
	evt keyValue = Character cr asciiValue
		ifTrue: [ 
			| answer |
			self announce: (answer := RubReturnEntered morph: self).
			answer accepted
				ifTrue: [ self editor textWasAccepted ] ]
		ifFalse: [ super keyStroke: evt ]
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> mouseDown: event [
	|selectors|
	self isEnabled ifTrue: [ ^ super mouseDown: event ].
	
	selectors := Array
				with: nil
				with: #doubleClick:
				with: #singleClick:
				with: (self dragEnabled
						ifTrue: [#startDrag:]).
	event hand
		waitForClicksOrDrag: self
		event: event
		selectors: selectors
		threshold: 10.
]

{ #category : #private }
GLMRubricTextFieldArea >> newParagraph [
	^ RubExtraSelectionDecorator next: super newParagraph
]

{ #category : #editing }
GLMRubricTextFieldArea >> privateReplaceFrom: start to: stop with: aText [
	| newText  |
	newText := aText.
	" it is possible to have cr in case of copy-paste "
	(aText string includesAnyOf: {(Character cr). (Character lf)})
		ifTrue: [ 
			newText := newText asString copyReplaceAll: String cr with: '' asTokens: false.
			newText := (newText asString copyReplaceAll: String lf with: '' asTokens: false) asText ].
	super privateReplaceFrom: start to: stop with: newText
]

{ #category : #'event handling' }
GLMRubricTextFieldArea >> singleClick: anEvent [
	
	self isEnabled ifTrue: [ ^ super click: anEvent ].

	"sorry for such a dirty hack"
	self owner owner owner owner owner container  
		ifNotNil: [ :aContainer | aContainer listManager mouseUp: anEvent on: self owner owner owner owner owner. ]
		
]

{ #category : #settings }
GLMRubricTextFieldArea >> walkAlongDisplayedLine [
	^ false
]
