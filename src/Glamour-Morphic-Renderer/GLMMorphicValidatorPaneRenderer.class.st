Class {
	#name : #GLMMorphicValidatorPaneRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'container',
		'paneMorph',
		'buttons'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> actOnMatchingPresentationsChanged: anAnnouncement [ 
	paneMorph	removeAllMorphs.
	self renderMorphFor: anAnnouncement pane.
	self renderer window fullBounds
]

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> buttonRowFrom: aCollectionOfButtons [
	"Answer a new ok/cancel button row."

	|answer buttons e|
	buttons := aCollectionOfButtons.
	e := 0@0.
	buttons do: [:b | e := e max: b minExtent].
	buttons do: [:b | b extent: e].
	answer := Morph new
		color: Color transparent;
		changeTableLayout;
		cellInset: 8;
		listDirection: #leftToRight;
		listCentering: #bottomRight;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap.
	buttons do: [:b | answer addMorphBack: b].
	^answer

	
]

{ #category : #accessing }
GLMMorphicValidatorPaneRenderer >> buttons [

	^ buttons
]

{ #category : #accessing }
GLMMorphicValidatorPaneRenderer >> buttons: aCollectionOfButtons [

	buttons := aCollectionOfButtons
]

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> newColumnWith: aCollectionOfMorphElements [
	"use this method to create a new column in your block"
	<lint: 'Utility methods' rationale: 'defined here to facilate the use of the library' author: 'cyrille.delaunay'>
	
	|answer|
	answer := PanelMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		fillStyle: Color transparent; "non pane color tracking"
		changeTableLayout;
		cellInset: 8; yourself.
	aCollectionOfMorphElements do: [:m | answer addMorphBack: m].
	^answer
]

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> render: aPane [

	paneMorph := GLMMorphic containerMorph.
	aPane
		on: GLMMatchingPresentationsChanged
		send: #actOnMatchingPresentationsChanged:
		to: self.
	self renderMorphFor: aPane.
	^ paneMorph
]

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> renderCompositiePresentation: aCompositePresentation [
	
	paneMorph := GLMMorphic containerMorph.
	paneMorph
		addMorph: 
			(self newColumnWith:  { (self renderObject: aCompositePresentation).  (self buttonRowFrom: self buttons) }) 
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		"addMorphBack: (self buttonRowFrom: self buttons)  ;  "
		adoptPaneColor: paneMorph paneColor.
	
	^ paneMorph
]

{ #category : #rendering }
GLMMorphicValidatorPaneRenderer >> renderMorphFor: aPane [

	paneMorph
		addMorph: 
			(self newColumnWith:  { (self renderObject: aPane presentations).  (self buttonRowFrom: self buttons) }) 
			fullFrame: (LayoutFrame fractions: (0 @ 0 corner: 1 @ 1));
		"addMorphBack: (self buttonRowFrom: self buttons)  ;  "
		adoptPaneColor: paneMorph paneColor
]