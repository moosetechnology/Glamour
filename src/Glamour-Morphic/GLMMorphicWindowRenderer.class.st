Class {
	#name : #GLMMorphicWindowRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#category : #'Glamour-Morphic'
}

{ #category : #rendering }
GLMMorphicWindowRenderer >> render: aRenderable [
	| dock offset bottomOffset statusbarMorph window |
	window := GLMSystemWindow new.
	window
		model: aRenderable;
		setLabel: (aRenderable titleValue ifNil: ['Glamorous Browser']).
	offset := 0.
	bottomOffset := 0.
	aRenderable allActions notEmpty ifTrue: [
		dock := self 
			renderToolbarForBrowser: aRenderable
			inWindow: window.
		offset := dock minExtent y.
		window 
			addMorph: dock
			fullFrame: (LayoutFrame 
					fractions: (0 @ 0 corner: 1 @ 0)
					offsets: (0 @ 0 corner: 0 @ offset)) ].
	aRenderable hasStatusbar ifTrue: [
		statusbarMorph := self renderPaneWithoutTitle: aRenderable statusbarPane.
		bottomOffset := 0 - ((LabelMorph contents: 'XXX') minHeight)*1.2.
		window 
				addMorph: statusbarMorph
				fullFrame: (LayoutFrame 
					fractions: (0 @ 1 corner: 1 @ 1)
					offsets: (2 @ bottomOffset corner: -2 @ 0)) ].
	window 
		addMorph: (self renderObject: aRenderable)
		fullFrame: (LayoutFrame 
				fractions: (0 @ 0 corner: 1 @ 1)
				offsets: (0 @ offset corner: 0 @ bottomOffset)).
	(self theme isKindOf: UIThemeWatery) ifFalse: [
		aRenderable colorValue ifNotNil: [ window paneColor: aRenderable colorValue ] ].
	^ window
]
