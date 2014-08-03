Class {
	#name : #GLMErrorPopper,
	#superclass : #GLMPopper,
	#category : #'Glamour-Morphic-Widgets-Popper'
}

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
