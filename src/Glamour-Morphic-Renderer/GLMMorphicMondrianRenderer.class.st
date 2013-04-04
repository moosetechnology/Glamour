Class {
	#name : #GLMMorphicMondrianRenderer,
	#superclass : #GLMMorphicWidgetRenderer,
	#instVars : [
		'canvasScrollPane',
		'mondrianCanvas'
	],
	#category : #'Glamour-Morphic-Renderer'
}

{ #category : #private }
GLMMorphicMondrianRenderer >> actOnContextChanged: ann [
	ann property = #selection ifTrue: [ 
		mondrianCanvas selected: (mondrianCanvas root deepFindNodeWithEntity: ann value) ]
]

{ #category : #private }
GLMMorphicMondrianRenderer >> actOnPresentationUpdate: ann [
	ann presentation view: MOViewRenderer new.
	canvasScrollPane scroller removeMorph: canvasScrollPane scroller submorphs first.
	self mondrianCanvasFor: ann presentation
]

{ #category : #private }
GLMMorphicMondrianRenderer >> mondrianCanvasFor: aPresentation [
	| view |
	view := aPresentation view.
	view root interaction menu: [ :x | self menuIn: MenuMorph new for: aPresentation ].
	aPresentation renderOn: view.
	mondrianCanvas := aPresentation canvas.
	mondrianCanvas announcer
			when: MOElementSelection
			do: [ :ann | aPresentation selection: ann element model ].
	mondrianCanvas announcer
			when: MOMouseEnter
			do: [ :ann | aPresentation status: ann element model ].
	mondrianCanvas announcer
			when: MOMouseLeave
			do: [ :ann | aPresentation status: nil ].
	canvasScrollPane scroller addMorph: mondrianCanvas
]

{ #category : #rendering }
GLMMorphicMondrianRenderer >> render: aPresentation [
	canvasScrollPane := ScrollPane new.
	self mondrianCanvasFor: aPresentation.
	canvasScrollPane
		color: Color white;
		vResizing: #spaceFill;
		hResizing: #spaceFill.
	aPresentation on: GLMPresentationUpdated send: #actOnPresentationUpdate: to: self.
	aPresentation on: GLMContextChanged send: #actOnContextChanged: to: self.
	^ canvasScrollPane
]
