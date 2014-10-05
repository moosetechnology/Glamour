"
I am a popper that displays an error message.

GLMErrorPopper simpleErrorPopper
"
Class {
	#name : #GLMErrorPopper,
	#superclass : #GLMPopper,
	#category : #'Glamour-Morphic-Widgets-Popper'
}

{ #category : #examples }
GLMErrorPopper class >> simpleErrorPopper [
	"
	self simpleErrorPopper
	"

	(GLMErrorPopper new 
		withString: 'error message goes here' 
		from: RubScrolledTextMorph new) openInWorld
]

{ #category : #initialization }
GLMErrorPopper >> initialize [
	super initialize.
	self initializeTextMorph
]

{ #category : #initialization }
GLMErrorPopper >> initializeTextMorph [
	textMorph := RubScrolledTextMorph new.
	textMorph
		beReadOnly;
		beWrapped;
		color: Color paleRed.
	self
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		addMorph: textMorph fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1))
]
