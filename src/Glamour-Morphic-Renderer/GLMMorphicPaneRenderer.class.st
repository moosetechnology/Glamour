Class {
	#name : #GLMMorphicPaneRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicPaneRenderer >> render: aPane [
	| container |
	container := GLMMorphic containerMorph.
	aPane when: GLMMatchingPresentationsChanged do: [ :ann | 
		container
			removeAllMorphs;
			addMorph: (self renderWithTitleOrNil: aPane presentations)
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			adoptPaneColor: container paneColor.
		self renderer window fullBounds ].
	container
		addMorph: (self renderWithTitleOrNil: aPane presentations)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: container paneColor.
	^ container
]
