Class {
	#name : #GLMPrintPopper,
	#superclass : #GLMPopper,
	#instVars : [
		'inspectButton'
	],
	#category : #'Glamour-Morphic-Widgets-Popper'
}

{ #category : #public }
GLMPrintPopper >> evaluateAndOpenFromRubric: aMorph [
	| string result |
	result := aMorph textArea editor evaluateSelectionAndDo: [ :x | x ].
	string := result asString.
	self withString: string from: aMorph.
	self width: self width + inspectButton width.
	textMorph
		on: $i command
		do: [ result inspect ].
	inspectButton addUpAction: [ result inspect ].
	self openInWorld
]

{ #category : #initialization }
GLMPrintPopper >> initialize [
	super initialize.
	self initializeInspectButton.
	self initializeTextMorph
]

{ #category : #initialization }
GLMPrintPopper >> initializeInspectButton [
	inspectButton := MultistateButtonMorph new
		extent: GLMUIThemeExtraIcons glamorousInspect extent;
		activeEnabledOverUpFillStyle: (ImageFillStyle form: GLMUIThemeExtraIcons glamorousInspect);
		setBalloonText: 'Inspect' translated.
	self
		addMorph: inspectButton
		fullFrame: (LayoutFrame fractions: (1 @ 0 corner: 1 @ 0) offsets: (inspectButton width negated @ 6 corner: 6 @ 28))
]

{ #category : #initialization }
GLMPrintPopper >> initializeTextMorph [
	textMorph := RubScrolledTextMorph new.
	textMorph
		beReadOnly;
		beWrapped;
		color: BalloonMorph balloonColor.
	self
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		addMorph: textMorph fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ 0 corner: inspectButton width negated @ 0))
]
