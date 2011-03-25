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
GLMMorphicWindowRenderer >> render: aRenderable [
	| dock offset bottomOffset statusbarMorph |
	window := GLMSystemWindow new model:aRenderable .
	window model: aRenderable.
	window on: #keyStroke send: #handleKeyStroke: to: window.
	self installActionsOnUI: window fromPresentation: aRenderable.
	self setLabelOf: window for: aRenderable.
	offset := 4.
	bottomOffset := 0.
	(aRenderable allActions select: [:each | each hasIcon]) notEmpty ifTrue: [ 
		dock := self renderToolbarForPresentation: aRenderable inMorph: window.
		dock hResizing: #shrinkWrap.
		window toolbarBox: dock.
"		offset := dock minExtent y."
"		window addMorph: dock fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 0) offsets: (0 @ 0 corner: 0 @ offset))" ].
	aRenderable hasStatusbar
		ifTrue: [ 
			statusbarMorph := GLMMorphicPaneWithoutTitleRenderer render: aRenderable statusbarPane from: self renderer.
			bottomOffset := (0 - (LabelMorph contents: 'XXX') minHeight) * 1.2.
			window
				addMorph: statusbarMorph
				fullFrame: (LayoutFrame fractions: (0 @ 1 corner: 1 @ 1) offsets: (2 @ bottomOffset corner: -2 @ 0)) ].
	window
		addMorph: (self renderObject: aRenderable)
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ offset corner: 0 @ bottomOffset)).
	(self theme isKindOf: UIThemeWatery)
		ifFalse: [ aRenderable colorValue ifNotNil: [ window paneColor: aRenderable colorValue ] ].
	aRenderable on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	^ window
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> setLabelOf: window for: aRenderable [
	window	setLabel: (self titleFor: aRenderable).
]

{ #category : #rendering }
GLMMorphicWindowRenderer >> titleFor: aRenderable [
	^ aRenderable titleValue ifNil: [ 'Glamorous Browser' ]
]
