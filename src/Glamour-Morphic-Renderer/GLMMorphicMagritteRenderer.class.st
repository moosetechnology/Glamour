Class {
	#name : #GLMMorphicMagritteRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'scrollPane',
		'containerMorphClass'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicMagritteRenderer >> actOnPresentationUpdated: ann [
	scrollPane removeMorph: scrollPane submorphs last.
	scrollPane scrollTarget: (self magritteMorphFrom: ann presentation) 
]

{ #category : #rendering }
GLMMorphicMagritteRenderer >> magritteMorphFrom: aMagrittePresentation [
	| toShow description magritteMorph |
	toShow := aMagrittePresentation displayValue.
	description := (aMagrittePresentation magritteDescription glamourValue: toShow) copy.
	magritteMorph := (description asMorphOn: toShow)
		addButtons;
		morph.
	magritteMorph
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		layoutChanged.
	^ magritteMorph
]

{ #category : #rendering }
GLMMorphicMagritteRenderer >> render: aMagrittePresentation [		.
	scrollPane := GeneralScrollPane new.
	scrollPane changeScrollerTableLayout.
	scrollPane scrollTarget: (self magritteMorphFrom: aMagrittePresentation).
	scrollPane layoutFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1) offsets: (0 @ 25 corner: 0 @ 0)).

	aMagrittePresentation on: GLMPresentationUpdated send: #actOnPresentationUpdated: to: self.
	^ scrollPane
]
