"
This is a morph used for previewing print it actions.

It has a special ability to delete itself either when Esc is pressed, or when the focus is lost.
"
Class {
	#name : #GLMPopper,
	#superclass : #Morph,
	#instVars : [
		'textMorph'
	],
	#category : #'Glamour-Morphic-Widgets-Popper'
}

{ #category : #public }
GLMPopper >> computeOriginFor: aMorph [	
	| desiredTop desiredLeft |
	"self halt."
	aMorph textArea scrollSelectionIntoView: nil.
	desiredTop := aMorph textArea cursor positionInWorld y - 6.
						"unclear why 6 is the magic number"
	desiredLeft := aMorph textArea cursor right + aMorph positionInWorld x + 6.
	^ desiredLeft @ desiredTop
]

{ #category : #initialization }
GLMPopper >> initialize [
	super initialize.
	self changeProportionalLayout.
	self
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
		color: Color transparent
]

{ #category : #private }
GLMPopper >> updateWithString: string from: aMorph [
	textMorph
		updateTextWith: string;
		takeKeyboardFocus;
		on: Character escape do: [ 
			self delete.
			aMorph takeKeyboardFocus ];
		on: Character backspace do: [ 
			self delete.
			aMorph takeKeyboardFocus ];
		onAnnouncement: MorphLostFocus do: [ :ann | 
			self delete.
			aMorph takeKeyboardFocus ]
]

{ #category : #private }
GLMPopper >> withString: string from: aMorph [
	| top width left stringMorph height desiredOrigin |
	desiredOrigin := self computeOriginFor: aMorph.
	stringMorph := RubEditingArea new updateTextWith: string.
	width := stringMorph width + 12 min: World width / 3.
	left := desiredOrigin x + width > World width
		ifTrue: [ World width - width ]
		ifFalse: [ desiredOrigin x ].
	height := (stringMorph
		beWrapped;
		width: width;
		yourself) height + 2 min: World height / 3.
	top := desiredOrigin y + height > World height
		ifTrue: [ World height - height ]
		ifFalse: [ desiredOrigin y ].
	self updateWithString: string from: aMorph.
	self
		top: top;
		left: left;
		width: width;
		height: height
]
