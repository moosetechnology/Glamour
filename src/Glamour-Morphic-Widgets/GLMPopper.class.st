"
This is a morph used for previewing print it actions.

It has a special ability to delete itself either when Esc is pressed, or when the focus is lost.
"
Class {
	#name : #GLMPopper,
	#superclass : #Morph,
	#instVars : [
		'textMorph',
		'inspectButton'
	],
	#category : #'Glamour-Morphic-Widgets-Popper'
}

{ #category : #private }
GLMPopper >> atLeft: desiredLeft top: desiredTop withString: string withObject: anObject from: aMorph [
	| top width left stringMorph height |
	stringMorph := RubEditingArea new updateTextWith: string.
	width := stringMorph width + 12 min: World width / 3.
	left := desiredLeft + width > World width
		ifTrue: [ World width - width ]
		ifFalse: [ desiredLeft ].
	height := (stringMorph
		beWrapped;
		width: width;
		yourself) height + 2 min: World height / 3.
	top := desiredTop + height > World height
		ifTrue: [ World height - height ]
		ifFalse: [ desiredTop ].
	self updateWithString: string from: aMorph.
	textMorph on: $i command do: [ anObject inspect ].
	inspectButton addUpAction: [ anObject inspect ].
	self
		top: top;
		left: left;
		width: width + 16;
		height: height
]

{ #category : #initialization }
GLMPopper >> initialize [
	super initialize.
	self changeProportionalLayout.
	self
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ];
		color: Color transparent.
	self initializeInspectButton.
	self initializeTextMorph
]

{ #category : #initialization }
GLMPopper >> initializeInspectButton [
	inspectButton := MultistateButtonMorph new
		extent: GLMUIThemeExtraIcons glamorousInspect extent;
		activeEnabledOverUpFillStyle: (ImageFillStyle form: GLMUIThemeExtraIcons glamorousInspect);
		setBalloonText: 'Inspect' translated.
	self
		addMorph: inspectButton
		fullFrame: (LayoutFrame fractions: (1 @ 0 corner: 1 @ 0) offsets: (-16 @ 6 corner: 6 @ 28))
]

{ #category : #initialization }
GLMPopper >> initializeTextMorph [
	textMorph := RubScrolledTextMorph new.
	textMorph
		beReadOnly;
		beWrapped;
		color: Color paleYellow.
	self
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		addMorph: textMorph fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ 0 corner: -16 @ 0))
]

{ #category : #public }
GLMPopper >> openInWorldFromRubric: aMorph [
	| desiredTop desiredLeft string result |

	result := aMorph textArea editor evaluateSelectionAndDo: [ :x | x ].
	string := result asString.
	aMorph textArea scrollSelectionIntoView: nil.
	desiredTop := aMorph textArea cursor top + 
						aMorph positionInWorld y - 6.
						"unclear why 6 is the magic number"
	desiredLeft := aMorph textArea cursor right + aMorph positionInWorld x + 6.
	self
		atLeft: desiredLeft
		top: desiredTop
		withString: string
		withObject: result
		from: aMorph.
	self openInWorld
]

{ #category : #private }
GLMPopper >> updateWithString: string from: aMorph [
	textMorph
		updateTextWith: string;
"		takeKeyboardFocus;"
		on: Character escape do: [ 
			self delete.
			aMorph takeKeyboardFocus ];
		on: Character backspace do: [ 
			self delete.
			aMorph takeKeyboardFocus ];
		onAnnouncement: MorphLostFocus do: [ :ann | 
			self delete.
			aMorph takeKeyboardFocus ].
	aMorph textArea
		onAnnouncement: RubKeystroke do: [ :ann | 
			self delete.
			aMorph takeKeyboardFocus ]
]
