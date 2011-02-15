Class {
	#name : #GLMMorphicPaneWithoutTitleRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container',
		'paneMorph'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicPaneWithoutTitleRenderer >> actOnMatchingPresentationsChanged: anAnnouncement [ 
	paneMorph	removeAllMorphs.
	self renderMorphFor: anAnnouncement pane.
	self renderer window fullBounds
]

{ #category : #rendering }
GLMMorphicPaneWithoutTitleRenderer >> render: aPane [
	paneMorph := GLMMorphic containerMorph.
	aPane
		on: GLMMatchingPresentationsChanged
		send: #actOnMatchingPresentationsChanged:
		to: self.
	self renderMorphFor: aPane.
	^ paneMorph
]

{ #category : #rendering }
GLMMorphicPaneWithoutTitleRenderer >> renderMorphFor: aPane [
	paneMorph
		addMorph: (self renderObject: aPane presentations) fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: paneMorph paneColor
]
