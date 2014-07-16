Class {
	#name : #GLMPopper,
	#superclass : #BorderedMorph,
	#instVars : [
		'textMorph'
	],
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'as yet unclassified' }
GLMPopper >> atLeft: desiredLeft top: desiredTop withString: string from: aMorph [
	| top width left stringMorph |
	stringMorph := RubEditingArea new updateTextWith: string.
	width := (stringMorph width + 12) min: World width / 3.
	left := desiredLeft + width > World width
		ifTrue: [ World width - width ]
		ifFalse: [ desiredLeft ].
	top := desiredTop.
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
	textMorph textArea selectAll.
	self
		top: top;
		left: left;
		width: width;
		height: ((stringMorph beWrapped; width: width; yourself) height + 6 min: 100)
]

{ #category : #'as yet unclassified' }
GLMPopper >> initialize [
	super initialize.
	self changeProportionalLayout.

	self 
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
		color: Color paleYellow;
		borderColor: (Color gray alpha: 0.5).
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
