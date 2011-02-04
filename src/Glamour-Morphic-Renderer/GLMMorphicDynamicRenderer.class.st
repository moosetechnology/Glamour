Class {
	#name : #GLMMorphicDynamicRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicDynamicRenderer >> render: aPresentation [
	| container |
	container := GLMMorphic emptyMorph.
	container addMorph: (self renderObject: aPresentation currentPresentation) fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)).
	aPresentation when: GLMPresentationUpdated do: [ :ann |
		container removeAllMorphs.
		container addMorph: (self renderObject: aPresentation currentPresentation) fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)) ].
	^ container
]
