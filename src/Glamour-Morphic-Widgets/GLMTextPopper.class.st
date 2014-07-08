Class {
	#name : #GLMTextPopper,
	#superclass : #RubEditingArea,
	#category : #'Glamour-Morphic-Widgets'
}

{ #category : #'as yet unclassified' }
GLMTextPopper >> initialize [
	super initialize.
	self 
		beWrapped;
		backgroundColor: Color paleYellow;
		onAnnouncement: MorphLostFocus do: [ :ann | ann morph delete ]
]

{ #category : #'as yet unclassified' }
GLMTextPopper >> openInWorldFromRubric: aMorph [
	| top cursorLeft left width text |
	text := aMorph textArea editor evaluateSelectionAndDo: [ :result | result asString ].
	width := text asStringMorph width min: World width / 3.
	top := aMorph textArea cursor top + aMorph positionInWorld y.
	cursorLeft := aMorph textArea cursor right + aMorph positionInWorld x.
	left := cursorLeft + width > World width ifTrue: [ World width - width ] ifFalse: [ cursorLeft ].
	self
		takeKeyboardFocus;
		on: Character escape do: [ self delete. aMorph takeKeyboardFocus];
		top: top;
		left: left;
		width: width;
		updateTextWith: text;
		openInWorld
]
