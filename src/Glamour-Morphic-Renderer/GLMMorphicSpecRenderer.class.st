Class {
	#name : #GLMMorphicSpecRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #'as yet unclassified' }
GLMMorphicSpecRenderer >> actOnPresentationUpdated: ann [
	container removeAllMorphs.
	container addMorphBack: (self morphFrom: ann presentation)
]

{ #category : #'as yet unclassified' }
GLMMorphicSpecRenderer >> render: aPresentation [
	container := GLMMorphic containerMorph.
	container 
		changeTableLayout;
		listDirection: #leftToRight;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	
	container addMorphBack: aPresentation displayValue widget.
	
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.

	^ container
]