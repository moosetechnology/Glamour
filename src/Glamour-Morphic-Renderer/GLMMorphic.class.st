Class {
	#name : #GLMMorphic,
	#superclass : #Object,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphic class >> alignmentMorph: aCollectionOfMorphs [
	"Answer a row-oriented AlignmentMorph holding the given collection"
	| morph |

	morph:= AlignmentMorph new
		listDirection: #leftToRight;
		borderWidth: 0;
		color: Color transparent;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		layoutInset: 1;
		wrapCentering: #center;
		cellPositioning: #center.
	aCollectionOfMorphs do: [ :each | morph addMorphBack: each].
	^morph
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> emptyMorph [
	^ PanelMorph new
		layoutPolicy: ProportionalLayout new;
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		borderWidth: 0;
		yourself
]

{ #category : #'button styles' }
GLMMorphic class >> grayRoundedButtonStyle: button morph: aMorph pressed: aBoolean [
	button useRoundedCorners.
	(self isAlignmentMorph: aMorph)
		ifTrue: [
			aBoolean 
				ifTrue: [	aMorph lastSubmorph color: Color darkGray.
						button fillStyle: (button theme buttonNormalFillStyleFor: button) ]
				ifFalse:[	aMorph lastSubmorph color: Color white.
						button fillStyle: (button theme buttonSelectedFillStyleFor: button) ] ]
		ifFalse: [			
			aBoolean 
				ifTrue: [	aMorph color: Color darkGray.
						button color: Color veryLightGray ]
				ifFalse:[	aMorph color: Color white.
						button color: Color gray ] ]

]

{ #category : #'as yet unclassified' }
GLMMorphic class >> isAlignmentMorph: anObject [

	^anObject isMemberOf: AlignmentMorph
]

{ #category : #'button styles' }
GLMMorphic class >> isGrayRoundedButton: aSymbol [

	^aSymbol = #grayRoundedButton
		or:[ aSymbol = #default ]
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> isImageMorph: anObject [

	^anObject isMemberOf: ImageMorph
]

{ #category : #'button styles' }
GLMMorphic class >> isWhiteRectangledButton: aSymbol [
	^aSymbol = #whiteRectangledButton
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> morphElement: anObject [

	anObject isString
	ifTrue:[ ^StringMorph 
					contents: anObject 
					font: (LogicalFont 
						familyName: UITheme current buttonFont familyName
						pointSize: UITheme current buttonFont pointSize - 2) ].
	
	anObject isCollection 
	ifTrue: [ |row|
				row:= OrderedCollection new.
				anObject do: [ :e| row add: (self morphElement: e) ].
				^self alignmentMorph: row ].
				
	anObject isForm
	ifTrue:[ ^ImageMorph new newForm: anObject ].
	
	^self emptyMorph
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> styleButton: button morph: m pressed: aBoolean style: aSymbol [

	(self isGrayRoundedButton: aSymbol)
	ifTrue:[ self grayRoundedButtonStyle: button morph: m pressed: aBoolean ].
	
	(self isWhiteRectangledButton: aSymbol)
	ifTrue:[ self whiteRectangledButtonStyle: button morph: m pressed: aBoolean ]
]

{ #category : #'as yet unclassified' }
GLMMorphic class >> togglingButtonLabelled: anObject pressed: aBoolean style: aSymbol [
	| button oldLabel m |
	button := SimpleButtonMorph new.
	(oldLabel := button findA: StringMorph) ifNotNil: [ oldLabel delete ].
	m := self morphElement: anObject.
	
	button
		addMorph: m;
		borderStyle: (BorderStyle inset width: 1);
		borderColor: Color gray.

	(self isAlignmentMorph: m)
	ifTrue:[ 
		button extent: m width @ (m height - 2).
		m position: 0 @ -2 ]
	ifFalse:[ 
		(self isImageMorph: m)
		ifTrue: [ button borderColor: Color transparent.
					button extent: (m width + 6) @ m height ]
		ifFalse:[ button extent: (m width + 6) @ (m height + 2) ].
		m position: 3 @ 0.	"button center - (m extent // 2)" ].
		
	self styleButton: button morph: m pressed: aBoolean style: aSymbol.
	m lock.
	
	^ button
]

{ #category : #'button styles' }
GLMMorphic class >> whiteRectangledButtonStyle: button morph: aMorph pressed: aBoolean [

	button useSquareCorners.
	(self isAlignmentMorph: aMorph)
	ifTrue:[ 
		aBoolean 
		ifTrue: [ aMorph lastSubmorph color: Color white.
					button color: Color gray ]
		ifFalse:[ aMorph lastSubmorph color: Color black.
					button color: Color white ] ]
	ifFalse:[			
		aBoolean 
		ifTrue: [ aMorph color: Color white.
				   button color: Color gray ]
		ifFalse:[ aMorph color: Color black.
					button color: Color white ] ]
]
