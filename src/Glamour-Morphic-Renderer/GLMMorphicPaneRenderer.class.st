Class {
	#name : #GLMMorphicPaneRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicPaneRenderer >> actOnMatchingPresentationChanged: anAnnouncement [
	container removeAllMorphs.
	self renderContainerFor: anAnnouncement pane.
	self renderer window
		ifNotNil: [ 
			self flag: 'this check is fishy'.
			self renderer window fullBounds ]
]

{ #category : #rendering }
GLMMorphicPaneRenderer >> render: aPane [
	container := GLMMorphic containerMorph.
	self renderContainerFor: aPane.
	aPane on: GLMMatchingPresentationsChanged send: #actOnMatchingPresentationChanged: to: self.
	^ container
]

{ #category : #rendering }
GLMMorphicPaneRenderer >> renderContainerFor: aPane [
	container
		addMorph: (self renderWithTitleOrNil: aPane presentations) fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		adoptPaneColor: Color transparent
]
