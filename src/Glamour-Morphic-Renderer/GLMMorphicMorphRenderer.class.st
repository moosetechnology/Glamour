Class {
	#name : #GLMMorphicMorphRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'scrollPane',
		'containerMorphClass',
		'container'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicMorphRenderer >> actOnPresentationUpdated: ann [
	container removeAllMorphs.
	container addMorphBack: (self morphFrom: ann presentation)
]

{ #category : #rendering }
GLMMorphicMorphRenderer >> morphFrom: aMorphPresentation [
	^aMorphPresentation displayValue 
		vResizing: #spaceFill; 
		hResizing: #spaceFill;
		yourself
]

{ #category : #rendering }
GLMMorphicMorphRenderer >> render: aMorphPresentation [		.
	container := GLMMorphic containerMorph.
	container 
		changeTableLayout;
		listDirection: #leftToRight;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	
	container addMorphBack: (self morphFrom: aMorphPresentation).
	
	aMorphPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.

	^ container
]
