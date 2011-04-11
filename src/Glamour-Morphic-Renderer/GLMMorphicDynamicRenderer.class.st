Class {
	#name : #GLMMorphicDynamicRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicDynamicRenderer >> actOnPresentationUpdated: anAnnouncement [
	container removeAllMorphs.
	container 
		addMorph: (self renderObject: anAnnouncement presentation currentPresentation) 
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)) 
]

{ #category : #rendering }
GLMMorphicDynamicRenderer >> render: aPresentation [
	container := GLMMorphic containerMorph.
	container 
		addMorph: (self renderObject: aPresentation currentPresentation) 
		fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1)).
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	^ container
]
