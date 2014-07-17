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

{ #category : #'as yet unclassified' }
GLMPopper >> atLeft: desiredLeft top: desiredTop withString: string from: aMorph [
	| top width left stringMorph height |
	stringMorph := RubEditingArea new updateTextWith: string.
	width := (stringMorph width + 12) min: World width / 3.
	left := desiredLeft + width > World width
		ifTrue: [ World width - width ]
		ifFalse: [ desiredLeft ].
	height := (stringMorph beWrapped; width: width; yourself) height min: World height / 3.
	top := desiredTop + height > World height 
		ifTrue: [ World height - height ]
		ifFalse: [ desiredTop ].
	textMorph
		updateTextWith: string;
		takeKeyboardFocus;
		on: Character escape
			do: [ 
				self delete.
				aMorph takeKeyboardFocus ];
		onAnnouncement: MorphLostFocus
			do: [ :ann | 
					self delete.
					aMorph takeKeyboardFocus ].
	self
		top: top;
		left: left;
		width: width;
		height: height
]

{ #category : #'as yet unclassified' }
GLMPopper >> initialize [
	super initialize.
	self changeProportionalLayout.

	self 
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
		color: Color paleYellow.
	textMorph := RubScrolledTextMorph new.
	textMorph textArea 
		backgroundColor: Color transparent;
		beReadOnly.
	textMorph 
		beWrapped;
		color: Color transparent.
	self 
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		addMorph: textMorph
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1))
]

{ #category : #'as yet unclassified' }
GLMPopper >> openInWorldFromRubric: aMorph [
	| desiredTop desiredLeft string |
	string := aMorph textArea editor evaluateSelectionAndDo: [ :result | result asString ].
	aMorph textArea scrollSelectionIntoView: nil.
	desiredTop := aMorph textArea cursor top + aMorph positionInWorld y - 6 - aMorph textArea owner offset y.	"unclear why 6 is the magic number"
	desiredLeft := aMorph textArea cursor right + aMorph positionInWorld x.
	self
		atLeft: desiredLeft
		top: desiredTop
		withString: string
		from: aMorph.
	self openInWorld
]
