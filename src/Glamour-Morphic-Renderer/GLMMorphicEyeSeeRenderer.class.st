Class {
	#name : #GLMMorphicEyeSeeRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'canvasScrollPane',
		'eyeseeCanvas'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicEyeSeeRenderer >> actOnContextChanged: ann [
	"ann property = #selection ifTrue: [ 
		eyeseeCanvas selected: (eyeseeCanvas root deepFindNodeWithEntity: ann value) ]"
]

{ #category : #private }
GLMMorphicEyeSeeRenderer >> actOnPresentationUpdate: ann [
	ann presentation diagram: ESDiagramRenderer new.
	canvasScrollPane scroller removeMorph: canvasScrollPane scroller submorphs first.
	self eyeseeCanvasFor: ann presentation
]

{ #category : #private }
GLMMorphicEyeSeeRenderer >> eyeseeCanvasFor: aPresentation [
	| eyeseeRenderer |
	eyeseeRenderer := aPresentation eyeseeRenderer.
	aPresentation renderOn: eyeseeRenderer.
	eyeseeCanvas := aPresentation canvas.
	eyeseeCanvas announcer 
			when: MOElementSelection
			do: [ :ann | aPresentation selection: ann element model ].
	eyeseeCanvas announcer
			when: MOMouseEnter
			do: [ :ann | aPresentation status: ann element model ].
	eyeseeCanvas announcer
			when: MOMouseLeave
			do: [ :ann | aPresentation status: nil ].
	canvasScrollPane scroller addMorph: eyeseeCanvas
]

{ #category : #rendering }
GLMMorphicEyeSeeRenderer >> render: aPresentation [
	canvasScrollPane := ScrollPane new.
	self eyeseeCanvasFor: aPresentation.
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ canvasScrollPane
]
