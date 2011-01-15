Class {
	#name : #GLMMorphicMagritteRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicMagritteRenderer >> magritteMorphFrom: aMagrittePresentation [
	| toShow description magritteMorph |
	toShow := aMagrittePresentation displayValue.
	description := (aMagrittePresentation magritteDescription glamourValue: toShow) copy.
	description morphClass: MASilentContainerMorph.
	magritteMorph := (description asMorphOn: toShow)
		addButtons;
		morph.
	magritteMorph
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		layoutChanged.
	^ magritteMorph
]

{ #category : #rendering }
GLMMorphicMagritteRenderer >> render: aMagrittePresentation [
	| scrollPane | 
		.
	scrollPane := GeneralScrollPane new.
	scrollPane scrollTarget: (self magritteMorphFrom: aMagrittePresentation).
	scrollPane layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ 25 corner: 0 @ 0)).

	aMagrittePresentation when: GLMPresentationUpdated do: [:ann |
		scrollPane removeMorph: scrollPane submorphs last.
		scrollPane scrollTarget: (self magritteMorphFrom: aMagrittePresentation) ].

	^ scrollPane
]
