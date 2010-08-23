Class {
	#name : #GLMPaneRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMPaneRenderer >> render: aPane [
	| container |
	container := GLMMorphic emptyMorph.
	aPane when: GLMMatchingPresentationsChanged do: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self renderWithTitleOrNil: aPane presentations)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		renderer window fullBounds.
		renderer window refreshHorizontalScollbars ].
	container
		addMorph: (self renderWithTitleOrNil: aPane presentations)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]
