Class {
	#name : #GLMMorphicLabelRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'labelMorph'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicLabelRenderer >> actOnPresentationUpdated: anAnnouncement [
	labelMorph contents: anAnnouncement presentation formatedDisplayValue
]

{ #category : #rendering }
GLMMorphicLabelRenderer >> render: aLabelPresentation [
	labelMorph := (LabelMorph contents: aLabelPresentation formatedDisplayValue) 
			layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			font: StandardFonts haloFont;
			yourself.
	aLabelPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	^labelMorph
]
