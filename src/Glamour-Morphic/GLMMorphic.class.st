Class {
	#name : #GLMMorphic,
	#superclass : #Object,
	#category : #'Glamour-Morphic'
}

{ #category : #'as yet unclassified' }
GLMMorphic class >> emptyMorph [
	^ RectangleMorph new
		layoutPolicy: ProportionalLayout new;
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		borderWidth: 0;
		yourself
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> togglingButtonLabelled: aString pressed: aBoolean [
	| button oldLabel m |
	button := SimpleButtonMorph new.
	(oldLabel := button findA: StringMorph) ifNotNil: [ oldLabel delete ].
	m := StringMorph 
		contents: aString
		font: (LogicalFont 
				familyName: UITheme current buttonFont familyName
				pointSize: UITheme current buttonFont pointSize - 2).
	button extent: (m width + 6) @ m height.
	m position: 3 @ 0.	"button center - (m extent // 2)"
	m lock.
	button
		addMorph: m;
		borderStyle: (BorderStyle inset width: 1);
		borderColor: Color gray;
		useRoundedCorners.
	aBoolean 
		ifFalse: 
			[ m color: Color white.
			button color: Color gray ]
		ifTrue: 
			[ m color: Color darkGray.
			button color: Color veryLightGray ].
	^ button
]
