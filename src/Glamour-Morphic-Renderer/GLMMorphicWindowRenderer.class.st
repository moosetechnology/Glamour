"
This renders the top most browser or composite presentation in a window.
"
Class {
	#name : #GLMMorphicWindowRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'window'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicWindowRenderer >> actOnPresentationUpdated: ann [
		self setLabelOf: window for: ann presentation
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> handlePotentialStatusbarFor: aRenderable [
	| statusbarMorph bottomOffset |
	bottomOffset := 0.
	aRenderable hasStatusbar
		ifTrue: [ 
			statusbarMorph := GLMMorphicPaneWithoutTitleRenderer render: aRenderable statusbarPane from: self renderer.
			bottomOffset := (0 - (LabelMorph contents: 'XXX') minHeight) * 1.2.
			window
				addMorph: statusbarMorph
				fullFrame: (LayoutFrame fractions: (0 @ 1 corner: 1 @ 1) offsets: (2 @ bottomOffset corner: -2 @ 0)) ].
	^ bottomOffset
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> render: aRenderable [
	| dock offset bottomOffset |
	window := GLMSystemWindow new model: aRenderable.
	self installActionsOnUI: window fromPresentation: aRenderable.
	self setLabelOf: window for: aRenderable.
	offset := 4.
	bottomOffset := 0.
	dock := self renderToolbarForPresentation: aRenderable inMorph: window.
	dock hResizing: #shrinkWrap.
	window toolbarBox: dock.
	bottomOffset := self handlePotentialStatusbarFor: aRenderable.
	window
		addMorph: (self renderObject: aRenderable)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ offset corner: 0 @ bottomOffset)).
	self setPotentialBackgroundColorFor: aRenderable.
	
	aRenderable on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	
	aRenderable watcherPane notNil ifTrue: [
		GLMMorphicWatcherRenderer render: aRenderable watcherPane from: self renderer ].
	
	^ window
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> setLabelOf: window for: aRenderable [
	window	setLabel: (self titleFor: aRenderable).
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> setPotentialBackgroundColorFor: aRenderable [
	(self theme isKindOf: UIThemeWatery)
		ifFalse: [ aRenderable colorValue ifNotNil: [ window paneColor: aRenderable colorValue ] ]
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> titleFor: aRenderable [
	^ aRenderable titleValue ifNil: [ 'Glamorous Browser' ]
]
